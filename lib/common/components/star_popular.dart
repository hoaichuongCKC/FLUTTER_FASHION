import 'dart:math' as math;
import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double _radius;
  final String _text;

  StarPainter({required double radius, required String text})
      : _radius = radius,
        _text = text;

  @override
  void paint(Canvas canvas, Size size) {
    const double angle = math.pi / 5;
    const double halfAngle = angle / 2;
    final Path path = Path();
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = _radius;

    path.moveTo(
        centerX + (radius * math.cos(0)), centerY + (radius * math.sin(0)));

    for (int i = 1; i <= 5; i++) {
      path.lineTo(centerX + (radius * math.cos(angle * i - halfAngle)),
          centerY + (radius * math.sin(angle * i - halfAngle)));
      path.lineTo(centerX + (radius / 2 * math.cos(angle * i)),
          centerY + (radius / 2 * math.sin(angle * i)));
    }

    path.close();
    _paint.color = Colors.yellow;
    canvas.drawPath(path, _paint);

    _paint.color = Colors.black;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 1.0;
    canvas.drawPath(path, _paint);

    TextSpan span = TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 16),
      text: _text,
    );
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(centerX - tp.width / 2, centerY - tp.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
