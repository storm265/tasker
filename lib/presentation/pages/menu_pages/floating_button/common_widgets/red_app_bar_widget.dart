import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class ReadAppBarWidget extends StatelessWidget {
  const ReadAppBarWidget({
    Key? key,
    this.height = 45,
  }) : super(key: key);

  final double height;

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
