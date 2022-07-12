import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/wave_colors.dart';
import 'painter/background_wave_painter.dart';

class BackgroundWaveWidget extends StatelessWidget {
  final int pageIndex;
  const BackgroundWaveWidget({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomPaint(
        painter: BackgroundWave(color: WaveColors.backgroundColors[pageIndex]),
        size: const Size(double.infinity, 250),
      ),
    );
  }
}
