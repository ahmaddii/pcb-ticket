import 'package:flutter/material.dart';

class ScanFrameOverlay extends StatelessWidget {
  final double size;

  const ScanFrameOverlay({
    super.key,
    this.size = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerFramePainter(),
      ),
    );
  }
}

class _CornerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const length = 28.0;
    const radius = 18.0;

    final tl = Path()
      ..moveTo(0, radius + length)
      ..lineTo(0, radius)
      ..arcToPoint(const Offset(radius, 0), radius: const Radius.circular(radius))
      ..lineTo(radius + length, 0);
    canvas.drawPath(tl, paint);

    final tr = Path()
      ..moveTo(size.width - radius - length, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(
        Offset(size.width, radius),
        radius: const Radius.circular(radius),
      )
      ..lineTo(size.width, radius + length);
    canvas.drawPath(tr, paint);

    final bl = Path()
      ..moveTo(0, size.height - radius - length)
      ..lineTo(0, size.height - radius)
      ..arcToPoint(
        Offset(radius, size.height),
        radius: const Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(radius + length, size.height);
    canvas.drawPath(bl, paint);

    final br = Path()
      ..moveTo(size.width, size.height - radius - length)
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(
        Offset(size.width - radius, size.height),
        radius: const Radius.circular(radius),
      )
      ..lineTo(size.width - radius - length, size.height);
    canvas.drawPath(br, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
