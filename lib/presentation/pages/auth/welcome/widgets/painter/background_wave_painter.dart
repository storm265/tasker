import 'package:flutter/widgets.dart';

class BackgroundWave extends CustomPainter {
  Color color;
  BackgroundWave({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.889, size.height * 0.090);
    path_0.cubicTo(
      size.width * 0.889,
      size.height * 0.090,
      size.width * 0.600,
      size.height * 0.204,
      size.width * 0.351,
      size.height * 0.061,
    );
    path_0.cubicTo(
      size.width * 0.103,
      size.height * -0.080,
      size.width * -0.005,
      size.height * 0.074,
      size.width * -0.081,
      size.height * 0.017,
    );
    path_0.cubicTo(
      size.width * -0.156,
      size.height * -0.039,
      size.width * -0.089,
      size.height * 1.123,
      -2500,
      size.height * 1.123,
    );

    path_0.lineTo(
      size.width,
      size.height * 0.457,
    );
    path_0.lineTo(
      size.width * 0.889,
      size.height * 0.090,
    );
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color.withOpacity(0.5);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
