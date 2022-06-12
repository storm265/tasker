import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/painter/foreground_wave_painter.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/wave_colors.dart';

class ForegroundWaveWidget extends StatelessWidget {
  final int pageIndex;
  const ForegroundWaveWidget({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 450,
      child: CustomPaint(
        painter: ForegroundWave(color: WaveColors.backgroundColors[pageIndex]),
        size: const Size(500, 300),
      ),
    );
  }
}
