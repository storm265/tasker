import 'package:flutter/widgets.dart';

class BackgroundWave extends CustomPainter {
  Color color;
  BackgroundWave({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8893034, size.height * 0.09056602);
    path_0.cubicTo(
        size.width * 0.8893034,
        size.height * 0.09056602,
        size.width * 0.6003230,
        size.height * 0.2040527,
        size.width * 0.3518736,
        size.height * 0.06190586);
    path_0.cubicTo(
        size.width * 0.1034244,
        size.height * -0.08024141,
        size.width * -0.005720169,
        size.height * 0.07495742,
        size.width * -0.08100506,
        size.height * 0.01795242);
    path_0.cubicTo(
        size.width * -0.1562899,
        size.height * -0.03905254,
        size.width * -0.08910112,
        size.height * 1.123813,
        -2500,
        size.height * 1.123813);

    path_0.lineTo(size.width, size.height * 0.4579375);
    path_0.lineTo(size.width * 0.8893034, size.height * 0.09056602);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color =  color.withOpacity(0.5);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}