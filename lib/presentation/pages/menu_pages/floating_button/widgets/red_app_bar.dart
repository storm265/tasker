import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class FakeAppBar extends StatelessWidget {
  final double height;
  const FakeAppBar({Key? key, this.height = 45}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Palette.red,
      child: SizedBox(
        height: height,
        width: double.infinity,
      ),
    );
  }
}
