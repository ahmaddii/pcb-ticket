import 'package:flutter/material.dart';

class TicketQr extends StatelessWidget {
  final String data;
  final double size;

  const TicketQr({
    super.key,
    required this.data,
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.07),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: TicketQrPainter(seed: data.hashCode),
      ),
    );
  }
}

class TicketQrPainter extends CustomPainter {
  final int seed;

  const TicketQrPainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    const modules = 25;
    final cell = size.width / modules;
    final paint = Paint()..color = Colors.black;
    final rng = _Lcg(seed == 0 ? 1 : seed.abs());

    bool inFinder(int x, int y) {
      return _finderContains(x, y, 0, 0) ||
          _finderContains(x, y, modules - 7, 0) ||
          _finderContains(x, y, 0, modules - 7);
    }

    for (var y = 0; y < modules; y++) {
      for (var x = 0; x < modules; x++) {
        var filled = false;
        if (inFinder(x, y)) {
          filled = _finderModule(x, y, modules);
        } else if (y == 6 || x == 6) {
          filled = (x + y).isEven;
        } else {
          filled = rng.next() % 3 != 0;
        }
        if (filled) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x * cell, y * cell, cell * 0.92, cell * 0.92),
              Radius.circular(cell * 0.12),
            ),
            paint,
          );
        }
      }
    }
  }

  bool _finderContains(int x, int y, int ox, int oy) {
    return x >= ox && x < ox + 7 && y >= oy && y < oy + 7;
  }

  bool _finderModule(int x, int y, int modules) {
    late int ox;
    late int oy;
    if (x < 7 && y < 7) {
      ox = 0;
      oy = 0;
    } else if (x >= modules - 7 && y < 7) {
      ox = modules - 7;
      oy = 0;
    } else {
      ox = 0;
      oy = modules - 7;
    }
    final dx = x - ox;
    final dy = y - oy;
    final ring = dx == 0 || dy == 0 || dx == 6 || dy == 6;
    final inner = dx >= 2 && dx <= 4 && dy >= 2 && dy <= 4;
    return ring || inner;
  }

  @override
  bool shouldRepaint(covariant TicketQrPainter oldDelegate) {
    return oldDelegate.seed != seed;
  }
}

class _Lcg {
  int _state;
  _Lcg(this._state);

  int next() {
    _state = (1103515245 * _state + 12345) & 0x7fffffff;
    return _state;
  }
}
