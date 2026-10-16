import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class EnclosurePanoramaViewer extends StatefulWidget {
  final List<String> imageAssets;
  final double? height;
  final bool enableZoom;
  final bool showHint;
  final double initialLook;
  final BorderRadius borderRadius;
  final VoidCallback? onExpand;
  final bool showCompass;

  const EnclosurePanoramaViewer({
    super.key,
    required this.imageAssets,
    this.height = 180,
    this.enableZoom = true,
    this.showHint = true,
    this.initialLook = 0.18,
    this.borderRadius = const BorderRadius.all(Radius.circular(18)),
    this.onExpand,
    this.showCompass = true,
  });

  @override
  State<EnclosurePanoramaViewer> createState() =>
      _EnclosurePanoramaViewerState();
}

class _EnclosurePanoramaViewerState extends State<EnclosurePanoramaViewer>
    with TickerProviderStateMixin {
  double _yaw = 0;
  double _pitch = 0;
  double _zoom = 1.08;

  final Map<int, Offset> _pointers = {};
  double? _pinchStartDistance;
  double _pinchStartZoom = 1.08;

  bool _hasInteracted = false;
  bool _dragging = false;
  double _yawVelocity = 0;
  double _pitchVelocity = 0;
  Ticker? _ticker;
  Duration _lastTick = Duration.zero;

  List<String> get _faces {
    final items = widget.imageAssets;
    if (items.isEmpty) {
      return List<String>.filled(8, 'assets/images/stadium_splash.jpg');
    }
    return List<String>.generate(8, (i) => items[i % items.length]);
  }

  @override
  void initState() {
    super.initState();
    _yaw = widget.initialLook % 1.0;
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final dt = _lastTick == Duration.zero
        ? 1 / 60
        : (elapsed - _lastTick).inMicroseconds / 1e6;
    _lastTick = elapsed;
    if (dt <= 0 || dt > 0.08) return;
    if (_dragging) return;

    if (!_hasInteracted) {
      setState(() => _yaw = (_yaw + 0.008 * dt) % 1.0);
      return;
    }

    if (_yawVelocity.abs() < 0.0002 && _pitchVelocity.abs() < 0.0002) {
      _yawVelocity = 0;
      _pitchVelocity = 0;
      return;
    }

    _yawVelocity *= math.pow(0.88, dt * 60).toDouble();
    _pitchVelocity *= math.pow(0.82, dt * 60).toDouble();
    setState(() {
      _yaw = (_yaw + _yawVelocity) % 1.0;
      if (_yaw < 0) _yaw += 1.0;
      _pitch = (_pitch + _pitchVelocity).clamp(-0.32, 0.32);
    });
  }

  double _pointerDistance() {
    if (_pointers.length < 2) return 0;
    final points = _pointers.values.take(2).toList();
    return (points[0] - points[1]).distance;
  }

  void _onPointerDown(PointerDownEvent event) {
    _pointers[event.pointer] = event.localPosition;
    _dragging = true;
    _yawVelocity = 0;
    _pitchVelocity = 0;
    if (_pointers.length == 2) {
      _pinchStartDistance = _pointerDistance();
      _pinchStartZoom = _zoom;
    }
    if (!_hasInteracted) setState(() => _hasInteracted = true);
  }

  void _onPointerMove(PointerMoveEvent event, Size size) {
    final previous = _pointers[event.pointer];
    _pointers[event.pointer] = event.localPosition;
    if (previous == null || size.width <= 0) return;

    if (_pointers.length >= 2 &&
        widget.enableZoom &&
        _pinchStartDistance != null &&
        _pinchStartDistance! > 0) {
      final scale = _pointerDistance() / _pinchStartDistance!;
      setState(() => _zoom = (_pinchStartZoom * scale).clamp(1.0, 2.2));
      return;
    }

    final delta = event.localPosition - previous;
    // One screen-width drag ≈ 75° of look, like turning your head.
    final yawDelta = delta.dx / size.width * (75 / 360);
    final pitchDelta = delta.dy / size.height * 0.38;
    setState(() {
      _yaw = (_yaw - yawDelta) % 1.0;
      if (_yaw < 0) _yaw += 1.0;
      _pitch = (_pitch + pitchDelta).clamp(-0.32, 0.32);
    });
    _yawVelocity = -yawDelta * 0.55;
    _pitchVelocity = pitchDelta * 0.35;
  }

  void _onPointerUp(PointerUpEvent event) {
    _pointers.remove(event.pointer);
    if (_pointers.length < 2) _pinchStartDistance = null;
    if (_pointers.isEmpty) {
      _dragging = false;
      _yawVelocity = _yawVelocity.clamp(-0.028, 0.028);
      _pitchVelocity = _pitchVelocity.clamp(-0.02, 0.02);
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _pointers.remove(event.pointer);
    _dragging = _pointers.isNotEmpty;
    _pinchStartDistance = null;
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (!widget.enableZoom || event is! PointerScrollEvent) return;
    setState(() {
      _hasInteracted = true;
      _zoom = (_zoom * (1 - event.scrollDelta.dy * 0.0012)).clamp(1.0, 2.2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = widget.height ?? constraints.maxHeight;
        final size = Size(width, height);

        return ClipRRect(
          borderRadius: widget.borderRadius,
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: Color(0xFF07140F)),
                RawGestureDetector(
                  behavior: HitTestBehavior.opaque,
                  gestures: {
                    EagerGestureRecognizer:
                        GestureRecognizerFactoryWithHandlers<
                            EagerGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                      (recognizer) {},
                    ),
                  },
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: _onPointerDown,
                    onPointerMove: (event) => _onPointerMove(event, size),
                    onPointerUp: _onPointerUp,
                    onPointerCancel: _onPointerCancel,
                    onPointerSignal: _onPointerSignal,
                    child: _CylindricalPanorama(
                      images: _faces,
                      yaw: _yaw,
                      pitch: _pitch,
                      zoom: _zoom,
                    ),
                  ),
                ),
                const IgnorePointer(child: _CameraVignette()),
                if (widget.showHint && !_hasInteracted)
                  const IgnorePointer(
                    child: Center(child: _LookAroundHint()),
                  ),
                if (widget.showCompass)
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 10,
                    child: IgnorePointer(
                      child: _CompassHud(yaw: _yaw),
                    ),
                  ),
                if (widget.onExpand != null)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: widget.onExpand,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xCC0A1A14),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF2A3632)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.threesixty,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              '360° View',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CylindricalPanorama extends StatelessWidget {
  final List<String> images;
  final double yaw;
  final double pitch;
  final double zoom;

  const _CylindricalPanorama({
    required this.images,
    required this.yaw,
    required this.pitch,
    required this.zoom,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewW = constraints.maxWidth;
        final viewH = constraints.maxHeight;
        final n = images.length;
        final radius = viewW * 0.62;
        final panelW = 2 * radius * math.tan(math.pi / n) + 6;
        final panelH = viewH * 1.28;
        final yawRad = yaw * math.pi * 2;

        final faces = <({double depth, Widget child})>[];
        for (var i = 0; i < n; i++) {
          final angle = yawRad - i * (2 * math.pi / n);
          final depth = math.cos(angle);
          if (depth < -0.08) continue;
          faces.add((
            depth: depth,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.00105)
                ..rotateX(pitch * 0.72)
                ..rotateY(angle)
                ..translate(0.0, pitch * viewH * 0.12, -radius)
                ..scale(zoom, zoom),
              child: SizedBox(
                width: panelW,
                height: panelH,
                child: Image.asset(
                  images[i],
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.high,
                  gaplessPlayback: true,
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(color: Color(0xFF0F261E));
                  },
                ),
              ),
            ),
          ));
        }
        faces.sort((a, b) => a.depth.compareTo(b.depth));

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, viewH * 0.18 + pitch * 30),
              child: Container(
                width: viewW * 1.4,
                height: viewH * 0.7,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF1B8F46).withValues(alpha: 0.28),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            ...faces.map((face) => face.child),
          ],
        );
      },
    );
  }
}

class _CameraVignette extends StatelessWidget {
  const _CameraVignette();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.95,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.18),
            Colors.black.withValues(alpha: 0.55),
          ],
          stops: const [0.45, 0.78, 1],
        ),
      ),
    );
  }
}

class _LookAroundHint extends StatelessWidget {
  const _LookAroundHint();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0x9903140F),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF2A3632)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.threesixty, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                'Drag to look around the ground',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompassHud extends StatelessWidget {
  final double yaw;

  const _CompassHud({required this.yaw});

  static const _dirs = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];

  @override
  Widget build(BuildContext context) {
    final heading = ((yaw % 1.0) * 360).round() % 360;
    final dir = _dirs[((heading + 22) ~/ 45) % 8];

    return Column(
      children: [
        Text(
          '$dir  $heading°',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        Center(
          child: SizedBox(
            width: 120,
            height: 5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Align(
                  alignment: Alignment(-1 + (yaw % 1.0) * 2, 0),
                  child: Container(
                    width: 28,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C853),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Enclosure360Screen extends StatelessWidget {
  final String title;
  final List<String> imageAssets;
  final double initialLook;

  const Enclosure360Screen({
    super.key,
    required this.title,
    required this.imageAssets,
    this.initialLook = 0.18,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03140F),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '$title · 360°',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: EnclosurePanoramaViewer(
                  imageAssets: imageAssets,
                  height: null,
                  enableZoom: true,
                  showHint: true,
                  showCompass: true,
                  initialLook: initialLook,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16, top: 4),
              child: Text(
                'Drag to look around  ·  Pinch to zoom  ·  Tilt to look up/down',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
