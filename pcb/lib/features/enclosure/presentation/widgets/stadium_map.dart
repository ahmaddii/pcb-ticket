import 'dart:math' as math;

import 'package:flutter/material.dart';

class StadiumMap extends StatelessWidget {
  final String selectedId;
  final ValueChanged<String>? onSelected;

  const StadiumMap({
    super.key,
    this.selectedId = 'sohail_tanveer',
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
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

  // Sector definition: angles in degrees [0, 360) clockwise starting from 3 o'clock (0°)
  static final List<_EnclosureSector> _sectors = [
    _EnclosureSector(
      id: 'yasir_arafat',
      name: 'YASIR ARAFAT',
      startDeg: 2.0,
      endDeg: 44.0,
      color: const Color(0xFF1E56A0),
      hasRowLines: true,
      textColor: Colors.white,
    ),
    _EnclosureSector(
      id: 'javed_miandad',
      name: 'JAVED\nMIANDAD',
      startDeg: 48.0,
      endDeg: 68.0,
      color: const Color(0xFFD31010),
      hasRowLines: false,
      textColor: Colors.white,
    ),
    _EnclosureSector(
      id: 'pavilion',
      name: 'PAVILION',
      startDeg: 72.0,
      endDeg: 108.0,
      color: const Color(0xFF282828),
      hasRowLines: false,
      textColor: Colors.white70,
    ),
    _EnclosureSector(
      id: 'imran_khan',
      name: 'IMRAN\nKHAN',
      startDeg: 112.0,
      endDeg: 134.0,
      color: const Color(0xFFD31010),
      hasRowLines: false,
      textColor: Colors.white,
    ),
    _EnclosureSector(
      id: 'shoaib_akhter',
      name: 'SHOAIB AKHTER',
      startDeg: 138.0,
      endDeg: 178.0,
      color: const Color(0xFFFDD835),
      hasRowLines: true,
      textColor: const Color(0xFF1E1E1E),
    ),
    _EnclosureSector(
      id: 'sohail_tanveer',
      name: 'SOHAIL TANVEER',
      startDeg: 182.0,
      endDeg: 226.0,
      color: const Color(0xFF00A859),
      hasRowLines: true,
      textColor: Colors.white,
    ),
    _EnclosureSector(
      id: 'javed_akhter',
      name: 'JAVED\nAKHTER',
      startDeg: 230.0,
      endDeg: 266.0,
      color: const Color(0xFFD31010),
      hasRowLines: false,
      textColor: Colors.white,
    ),
    _EnclosureSector(
      id: 'azhar_mehmood',
      name: 'AZHAR\nMEHMOOD',
      startDeg: 274.0,
      endDeg: 312.0,
      color: const Color(0xFFD31010),
      hasRowLines: false,
      textColor: Colors.white,
    ),
    _EnclosureSector(
      id: 'miran_buksh',
      name: 'MIRAN BUKSH',
      startDeg: 316.0,
      endDeg: 358.0,
      color: const Color(0xFF1E56A0),
      hasRowLines: true,
      textColor: Colors.white,
    ),
  ];

  static const List<_GateBadge> _gates = [
    _GateBadge(number: '6', deg: 0.0),
    _GateBadge(number: '7', deg: 46.0),
    _GateBadge(number: '8', deg: 70.0),
    _GateBadge(number: '1', deg: 110.0),
    _GateBadge(number: '2', deg: 136.0),
    _GateBadge(number: '3', deg: 180.0),
    _GateBadge(number: '4', deg: 228.0),
    _GateBadge(number: '5', deg: 314.0),
  ];

  static String? enclosureAt(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rMax = math.min(size.width, size.height) / 2 * 0.94;
    final rInner = rMax * 0.58;
    final rOuter = rMax * 0.92;

    final dx = position.dx - center.dx;
    final dy = position.dy - center.dy;
    final dist = math.sqrt(dx * dx + dy * dy);

    if (dist < rInner - 8 || dist > rOuter + 14) return null;

    var rad = math.atan2(dy, dx);
    if (rad < 0) rad += 2 * math.pi;
    final deg = rad * 180 / math.pi;

    for (final s in _sectors) {
      if (s.contains(deg)) {
        return s.id;
      }
    }

    // Near gates or main entrance fallback
    if (deg >= 70.0 && deg <= 110.0) return 'pavilion';
    if (deg > 358.0 || deg < 2.0) return 'yasir_arafat';
    return null;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rMax = math.min(size.width, size.height) / 2 * 0.94;
    final rField = rMax * 0.58;
    final rInner = rField + 2.0;
    final rOuter = rMax * 0.90;
    final rGates = rMax * 0.96;

    // 1. Draw outer stadium background circle
    final outerRingPaint = Paint()
      ..color = const Color(0xFFFBFBFB)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, rOuter + 14, outerRingPaint);

    final outerRingBorder = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center, rOuter + 14, outerRingBorder);

    // 2. Draw Enclosure Sectors
    for (final s in _sectors) {
      final isSelected = selectedId == s.id ||
          (selectedId == 'general' && s.id == 'sohail_tanveer') ||
          (selectedId == 'first_class' && s.id == 'miran_buksh') ||
          (selectedId == 'premium' && s.id == 'shoaib_akhter') ||
          (selectedId == 'vip' && s.id == 'imran_khan');

      _drawSector(
        canvas: canvas,
        center: center,
        rInner: rInner,
        rOuter: rOuter,
        sector: s,
        isSelected: isSelected,
      );
    }

    // 3. Draw Main Entrance bottom box
    _drawMainEntrance(canvas, center, rInner, rOuter);

    // 4. Draw Sector Dividers (white architectural dividing spokes)
    _drawDividers(canvas, center, rInner, rOuter);

    // 5. Draw Gate labels and circle badges (1 to 8)
    _drawGates(canvas, center, rOuter, rGates);

    // 6. Draw Cricket Outfield (Striped grass, pitch, markings & text)
    _drawCricketField(canvas, center, rField);
  }

  void _drawSector({
    required Canvas canvas,
    required Offset center,
    required double rInner,
    required double rOuter,
    required _EnclosureSector sector,
    required bool isSelected,
  }) {
    final startRad = sector.startDeg * math.pi / 180;
    final sweepRad = (sector.endDeg - sector.startDeg) * math.pi / 180;

    final path = Path();
    path.arcTo(
      Rect.fromCircle(center: center, radius: rOuter),
      startRad,
      sweepRad,
      false,
    );
    path.arcTo(
      Rect.fromCircle(center: center, radius: rInner),
      startRad + sweepRad,
      -sweepRad,
      false,
    );
    path.close();

    // Fill sector
    final fillPaint = Paint()
      ..color = isSelected ? Color.lerp(sector.color, Colors.white, 0.15)! : sector.color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Concentric row lines for Shoaib Akhter, Sohail Tanveer, Miran Buksh, Yasir Arafat
    if (sector.hasRowLines) {
      final rowPaint = Paint()
        ..color = (sector.color == const Color(0xFFFDD835))
            ? const Color(0xFFE5BE10).withValues(alpha: 0.8)
            : Colors.black.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9;

      const rowSteps = 5;
      for (var r = 1; r < rowSteps; r++) {
        final rowRadius = rInner + (rOuter - rInner) * (r / rowSteps);
        final rowPath = Path();
        rowPath.arcTo(
          Rect.fromCircle(center: center, radius: rowRadius),
          startRad + 0.015,
          sweepRad - 0.03,
          false,
        );
        canvas.drawPath(rowPath, rowPaint);
      }
    }

    // Selected highlight outline
    if (isSelected) {
      final glowPaint = Paint()
        ..color = const Color(0xFF00FF66)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.2;
      canvas.drawPath(path, glowPaint);
    }

    // Draw Sector Text Label
    _drawSectorLabel(canvas, center, rInner, rOuter, sector);
  }

  void _drawSectorLabel(
    Canvas canvas,
    Offset center,
    double rInner,
    double rOuter,
    _EnclosureSector sector,
  ) {
    final midDeg = (sector.startDeg + sector.endDeg) / 2;
    final midRad = midDeg * math.pi / 180;
    final midRadius = (rInner + rOuter) / 2;
    final pos = Offset(
      center.dx + midRadius * math.cos(midRad),
      center.dy + midRadius * math.sin(midRad),
    );

    canvas.save();
    canvas.translate(pos.dx, pos.dy);

    // Orient label to match circular curvature
    var textRotation = midRad + math.pi / 2;
    if (midDeg > 0 && midDeg < 180) {
      textRotation += math.pi; // prevent upside down labels
    }
    canvas.rotate(textRotation);

    final isShoaib = sector.id == 'shoaib_akhter';
    final isSohail = sector.id == 'sohail_tanveer';
    final isMiran = sector.id == 'miran_buksh';
    final isYasir = sector.id == 'yasir_arafat';
    final isSingleLine = isShoaib || isSohail || isMiran || isYasir;

    final fontSize = isSingleLine ? 7.6 : 7.2;
    final textPainter = TextPainter(
      text: TextSpan(
        text: sector.name,
        style: TextStyle(
          color: sector.textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
          height: 1.1,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    canvas.restore();
  }

  void _drawMainEntrance(Canvas canvas, Offset center, double rInner, double rOuter) {
    const startRad = 84.0 * math.pi / 180;
    const sweepRad = 12.0 * math.pi / 180;

    final path = Path();
    path.arcTo(
      Rect.fromCircle(center: center, radius: rOuter + 4),
      startRad,
      sweepRad,
      false,
    );
    path.arcTo(
      Rect.fromCircle(center: center, radius: rInner),
      startRad + sweepRad,
      -sweepRad,
      false,
    );
    path.close();

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    final border = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(path, border);

    final midPos = Offset(
      center.dx + ((rInner + rOuter) / 2) * math.cos(90 * math.pi / 180),
      center.dy + ((rInner + rOuter) / 2) * math.sin(90 * math.pi / 180),
    );

    final tp = TextPainter(
      text: const TextSpan(
        text: 'MAIN\nENTRANCE',
        style: TextStyle(
          color: Color(0xFF222222),
          fontSize: 6.2,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.4,
          height: 1.1,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(midPos.dx - tp.width / 2, midPos.dy - tp.height / 2));
  }

  void _drawDividers(Canvas canvas, Offset center, double rInner, double rOuter) {
    final dividerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6;

    final dividerAngles = [
      0.0, 46.0, 70.0, 84.0, 96.0, 110.0, 136.0, 180.0, 228.0, 267.0, 273.0, 314.0
    ];

    for (final deg in dividerAngles) {
      final rad = deg * math.pi / 180;
      final p1 = Offset(
        center.dx + (rInner - 1) * math.cos(rad),
        center.dy + (rInner - 1) * math.sin(rad),
      );
      final p2 = Offset(
        center.dx + (rOuter + 3) * math.cos(rad),
        center.dy + (rOuter + 3) * math.sin(rad),
      );
      canvas.drawLine(p1, p2, dividerPaint);
    }
  }

  void _drawGates(Canvas canvas, Offset center, double rOuter, double rGates) {
    for (final gate in _gates) {
      final rad = gate.deg * math.pi / 180;

      // Draw "GATE" label radially inside
      final gateLabelRadius = rOuter - 6;
      final labelPos = Offset(
        center.dx + gateLabelRadius * math.cos(rad),
        center.dy + gateLabelRadius * math.sin(rad),
      );

      canvas.save();
      canvas.translate(labelPos.dx, labelPos.dy);
      var rot = rad + math.pi / 2;
      if (gate.deg > 0 && gate.deg < 180) rot += math.pi;
      canvas.rotate(rot);

      final labelTp = TextPainter(
        text: const TextSpan(
          text: 'GATE',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 5.8,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      labelTp.layout();
      labelTp.paint(canvas, Offset(-labelTp.width / 2, -labelTp.height / 2));
      canvas.restore();

      // Draw Gate circular badge
      final badgePos = Offset(
        center.dx + rGates * math.cos(rad),
        center.dy + rGates * math.sin(rad),
      );

      // Circle fill
      canvas.drawCircle(
        badgePos,
        10.5,
        Paint()..color = Colors.white,
      );
      // Circle stroke
      canvas.drawCircle(
        badgePos,
        10.5,
        Paint()
          ..color = const Color(0xFFB0B0B0)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );

      // Gate number text
      final numTp = TextPainter(
        text: TextSpan(
          text: gate.number,
          style: const TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 10.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      numTp.layout();
      numTp.paint(
        canvas,
        Offset(badgePos.dx - numTp.width / 2, badgePos.dy - numTp.height / 2),
      );
    }
  }

  void _drawCricketField(Canvas canvas, Offset center, double rField) {
    canvas.save();

    // Clip to outfield circle
    final fieldPath = Path()..addOval(Rect.fromCircle(center: center, radius: rField));
    canvas.clipPath(fieldPath);

    // Grass vertical stripes
    const numStripes = 14;
    final stripeWidth = (rField * 2) / numStripes;
    final left = center.dx - rField;
    final top = center.dy - rField;
    final height = rField * 2;

    for (var i = 0; i < numStripes; i++) {
      final stripeColor = (i % 2 == 0)
          ? const Color(0xFF27963C) // deeper manicured green
          : const Color(0xFF32A847); // lighter vibrant green

      canvas.drawRect(
        Rect.fromLTWH(left + i * stripeWidth, top, stripeWidth + 0.5, height),
        Paint()..color = stripeColor,
      );
    }

    // 30-yard fielding oval
    final circleOvalRect = Rect.fromCenter(
      center: center,
      width: rField * 0.70,
      height: rField * 0.90,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(circleOvalRect, Radius.circular(rField * 0.32)),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );

    // Pitch strip
    final pitchRect = Rect.fromCenter(
      center: center,
      width: 15.0,
      height: rField * 0.38,
    );
    final pitchRRect = RRect.fromRectAndRadius(pitchRect, const Radius.circular(2.5));
    canvas.drawRRect(
      pitchRRect,
      Paint()..color = const Color(0xFFD4BA88),
    );
    canvas.drawRRect(
      pitchRRect,
      Paint()
        ..color = const Color(0xFFBCA06C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );

    // Bowling creases
    final creasePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0;

    final topCreaseY = center.dy - rField * 0.15;
    final bottomCreaseY = center.dy + rField * 0.15;
    canvas.drawLine(
      Offset(center.dx - 6, topCreaseY),
      Offset(center.dx + 6, topCreaseY),
      creasePaint,
    );
    canvas.drawLine(
      Offset(center.dx - 6, bottomCreaseY),
      Offset(center.dx + 6, bottomCreaseY),
      creasePaint,
    );

    // Stumps dots
    final stumpPaint = Paint()..color = const Color(0xFF1E3A8A);
    canvas.drawCircle(Offset(center.dx, topCreaseY + 2.5), 1.4, stumpPaint);
    canvas.drawCircle(Offset(center.dx, bottomCreaseY - 2.5), 1.4, stumpPaint);

    // Fielding dots (scattered white and yellow dots)
    final whiteDotPaint = Paint()..color = Colors.white;
    final yellowDotPaint = Paint()..color = const Color(0xFFFFEB3B);

    canvas.drawCircle(Offset(center.dx - rField * 0.24, center.dy - rField * 0.22), 2.2, whiteDotPaint);
    canvas.drawCircle(Offset(center.dx - rField * 0.04, center.dy - rField * 0.14), 2.0, whiteDotPaint);
    canvas.drawCircle(Offset(center.dx + rField * 0.14, center.dy - rField * 0.04), 2.2, yellowDotPaint);
    canvas.drawCircle(Offset(center.dx - rField * 0.28, center.dy + rField * 0.10), 2.0, whiteDotPaint);
    canvas.drawCircle(Offset(center.dx + rField * 0.05, center.dy + rField * 0.22), 2.2, yellowDotPaint);
    canvas.drawCircle(Offset(center.dx + rField * 0.26, center.dy + rField * 0.28), 2.0, whiteDotPaint);

    // Top text: "PINDI\nSTADIUM"
    final pindiTp = TextPainter(
      text: const TextSpan(
        text: 'PINDI',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.2,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    pindiTp.layout();
    pindiTp.paint(
      canvas,
      Offset(center.dx - pindiTp.width / 2, center.dy - rField * 0.65),
    );

    final stadiumTp = TextPainter(
      text: const TextSpan(
        text: 'S T A D I U M',
        style: TextStyle(
          color: Colors.white,
          fontSize: 7.2,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.8,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    stadiumTp.layout();
    stadiumTp.paint(
      canvas,
      Offset(center.dx - stadiumTp.width / 2, center.dy - rField * 0.65 + pindiTp.height + 1.0),
    );

    // Bottom text: "RAWALPINDI"
    final rawalpindiTp = TextPainter(
      text: const TextSpan(
        text: 'RAWALPINDI',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.8,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    rawalpindiTp.layout();
    rawalpindiTp.paint(
      canvas,
      Offset(center.dx - rawalpindiTp.width / 2, center.dy + rField * 0.60),
    );

    canvas.restore();

    // Boundary rope line
    final boundaryPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    canvas.drawCircle(center, rField, boundaryPaint);
  }

  @override
  bool shouldRepaint(covariant StadiumMapPainter oldDelegate) {
    return oldDelegate.selectedId != selectedId;
  }
}

class _EnclosureSector {
  final String id;
  final String name;
  final double startDeg;
  final double endDeg;
  final Color color;
  final bool hasRowLines;
  final Color textColor;

  const _EnclosureSector({
    required this.id,
    required this.name,
    required this.startDeg,
    required this.endDeg,
    required this.color,
    required this.hasRowLines,
    required this.textColor,
  });

  bool contains(double deg) {
    if (startDeg <= endDeg) {
      return deg >= startDeg && deg <= endDeg;
    }
    // wrap around 360
    return deg >= startDeg || deg <= endDeg;
  }
}

class _GateBadge {
  final String number;
  final double deg;

  const _GateBadge({
    required this.number,
    required this.deg,
  });
}
