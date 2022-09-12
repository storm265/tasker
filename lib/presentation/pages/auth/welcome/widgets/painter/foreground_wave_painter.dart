import 'package:flutter/widgets.dart';

class ForegroundWave extends CustomPainter {
  Color color;
  ForegroundWave({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.00069, size.height * 0.094);
    path_0.cubicTo(
      size.width * 0.00069,
      size.height * 0.094,
      size.width * 0.30,
      size.height * 0.21,
      size.width * 0.56,
      size.height * 0.064,
    );
    path_0.cubicTo(
      size.width * 0.8,
      size.height * -0.08,
      size.width * 0.93,
      size.height * 0.077,
      size.width * 1.011,
      size.height * 0.018,
    );
    path_0.cubicTo(
      size.width * 1.090,
      size.height * -0.040,
      size.width * 1.020,
      size.height * 1.168,
      size.width * 1.020,
      size.height * 1.168,
    );

    path_0.lineTo(
      size.width * -0.06454987,
      size.height * 1.168,
    );

    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
