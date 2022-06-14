import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.02500000;
    paint_0_stroke.color = Color(0xffF96060).withOpacity(1.0);
    paint_0_stroke.strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.4938272),
        size.width * 0.5000000, paint_0_stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
