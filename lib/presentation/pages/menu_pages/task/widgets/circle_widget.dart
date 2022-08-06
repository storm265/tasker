import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class CirclePainter extends CustomPainter {
  Color circleColor=getAppColor(color: CategoryColor.blue);
  CirclePainter({required this.circleColor});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..color = circleColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
