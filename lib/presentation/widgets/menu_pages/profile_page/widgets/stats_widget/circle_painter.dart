import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Colors.red;
    path = Path();
    path.lineTo(size.width, size.height / 2);
    path.cubicTo(size.width, size.height * 0.78, size.width * 0.78, size.height,
        size.width / 2, size.height);
    path.cubicTo(size.width * 0.22, size.height, 0, size.height * 0.78, 0,
        size.height / 2);
    path.cubicTo(
        0, size.height * 0.22, size.width * 0.22, 0, size.width / 2, 0);
    path.cubicTo(size.width * 0.78, 0, size.width, size.height * 0.22,
        size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
