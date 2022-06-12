import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/wave_colors.dart';
import 'painter/background_wave_painter.dart';

class BackgroundWaveWidget extends StatelessWidget {
  final int pageIndex;
  const BackgroundWaveWidget({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 455,
      child: CustomPaint(
        painter: BackgroundWave(color: WaveColors.backgroundColors[pageIndex]),
        size: const Size(500, 230),
      ),
    );
  }
}
