import 'package:flutter/material.dart';
import 'package:todo2/presentation/welcome_page/widgets/wave_colors.dart';
import 'package:todo2/presentation/welcome_page/widgets/painter/foreground_wave_painter.dart';

class ForegroundWaveWidget extends StatelessWidget {
  final double width;
  final int pageIndex;
  const ForegroundWaveWidget(
      {Key? key, required this.pageIndex, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 450,
      child: CustomPaint(
        painter: ForegroundWave(color: WaveColors.backgroundColors[pageIndex]),
        size: Size(width, 300),
      ),
    );
  }
}
