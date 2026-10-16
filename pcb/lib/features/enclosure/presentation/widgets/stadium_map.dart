import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/enclosure_catalog.dart';

class StadiumMap extends StatelessWidget {
  final String selectedId;
  final ValueChanged<String>? onSelected;

  const StadiumMap({
    super.key,
    this.selectedId = 'general',
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onTapDown: (details) {
            final id = StadiumMapPainter.enclosureAt(
              details.localPosition,
              size,
            );
            if (id != null) onSelected?.call(id);
          },
          child: CustomPaint(
            painter: StadiumMapPainter(selectedId: selectedId),
            size: size,
          ),
        );
      },
    );
  }
}

class StadiumMapPainter extends CustomPainter {
  final String selectedId;

  const StadiumMapPainter({required this.selectedId});

  static String? enclosureAt(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rx = size.width * 0.46;
    final ry = size.height * 0.42;
    final nx = (position.dx - center.dx) / rx;
    final ny = (position.dy - center.dy) / ry;
    final r = math.sqrt(nx * nx + ny * ny);
    if (r < 0.46 || r > 1.05) return null;
    if (r < 0.62) return 'vip';
    if (r < 0.76) return 'premium';
    if (r < 0.88) return 'first_class';
    return 'general';
  }

  Color _seatColor(int ring, int index) {
    final palette = <Color>[
      const Color(0xFF1FA85A),
      const Color(0xFF2F6BFF),
      const Color(0xFF7C4DFF),
      const Color(0xFFE0B43C),
      const Color(0xFF14B8A6),
      const Color(0xFFFB923C),
    ];

    late String id;
    if (ring <= 1) {
      id = 'vip';
    } else if (ring == 2) {
      id = 'premium';
    } else if (ring == 3) {
      id = 'first_class';
    } else {
      id = 'general';
    }

    final accent = index % 11 == 0 ? palette[(ring + index) % palette.length] : null;
    final base = EnclosureCatalog.byId(id).color;
    if (selectedId == id) {
      return Color.lerp(base, Colors.white, 0.18)!;
    }
    return accent ?? base.withValues(alpha: 0.9);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rx = size.width * 0.46;
    final ry = size.height * 0.42;

    canvas.drawOval(
      Rect.fromCenter(center: center, width: rx * 2.18, height: ry * 2.28),
      Paint()..color = const Color(0xFF0A1F18),
    );

    const rings = 6;
    const seats = 40;
    for (var ring = rings - 1; ring >= 0; ring--) {
      final t = 0.54 + ring / rings * 0.44;
      final ringRx = rx * t;
      final ringRy = ry * t;
      for (var i = 0; i < seats; i++) {
        final angle = (i / seats) * math.pi * 2 - math.pi / 2;
        final pos = Offset(
          center.dx + ringRx * math.cos(angle),
          center.dy + ringRy * math.sin(angle),
        );
        final seatW = 9.0 + ring * 0.4;
        final seatH = 7.0 + ring * 0.25;
        final rect = Rect.fromCenter(center: pos, width: seatW, height: seatH);
        final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(2));
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(angle + math.pi / 2);
        canvas.translate(-pos.dx, -pos.dy);
        canvas.drawRRect(
          rrect,
          Paint()..color = _seatColor(ring, i),
        );
        canvas.restore();
      }
    }

    canvas.drawOval(
      Rect.fromCenter(center: center, width: rx * 1.02, height: ry * 1.02),
      Paint()..color = const Color(0xFF147A3A),
    );
    canvas.drawOval(
      Rect.fromCenter(center: center, width: rx * 0.88, height: ry * 0.86),
      Paint()..color = const Color(0xFF1B8F46),
    );

    final pitch = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 18, height: ry * 0.46),
      const Radius.circular(3),
    );
    canvas.drawRRect(pitch, Paint()..color = const Color(0xFFD9C27A));
    canvas.drawRRect(
      pitch,
      Paint()
        ..color = const Color(0xFFB59A4A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final crease = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(center.dx - 7, center.dy - ry * 0.16),
      Offset(center.dx + 7, center.dy - ry * 0.16),
      crease,
    );
    canvas.drawLine(
      Offset(center.dx - 7, center.dy + ry * 0.16),
      Offset(center.dx + 7, center.dy + ry * 0.16),
      crease,
    );
  }

  @override
  bool shouldRepaint(covariant StadiumMapPainter oldDelegate) {
    return oldDelegate.selectedId != selectedId;
  }
}
