import 'package:flutter/widgets.dart';

class ForegroundWave extends CustomPainter {
  Color color;
  ForegroundWave({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0006925253, size.height * 0.09419704);
    path_0.cubicTo(
        size.width * 0.0006925253,
        size.height * 0.09419704,
        size.width * 0.3018453,
        size.height * 0.2122333,
        size.width * 0.5607627,
        size.height * 0.06438741);
    path_0.cubicTo(
        size.width * 0.8196773,
        size.height * -0.08345815,
        size.width * 0.9334187,
        size.height * 0.07796259,
        size.width * 1.011877,
        size.height * 0.01867215);
    path_0.cubicTo(
        size.width * 1.090333,
        size.height * -0.04061815,
        size.width * 1.020312,
        size.height * 1.168867,
        size.width * 1.020312,
        size.height * 1.168867);

    path_0.lineTo(size.width * -0.06454987, size.height * 1.168867);

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
