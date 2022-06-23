import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.02500000;
    paint0Stroke.color = const Color(0xffF96060).withOpacity(1.0);
    paint0Stroke.strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.4938272),
        size.width * 0.5000000, paint0Stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
