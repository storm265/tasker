import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/wave_colors.dart';
import 'painter/foreground_wave_painter.dart';

class ForegroundWaveWidget extends StatelessWidget {
  final int pageIndex;
  const ForegroundWaveWidget({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomPaint(
        painter: ForegroundWave(color: waveColors[pageIndex]),
        size: const Size(double.infinity, 260),
      ),
    );
  }
}
