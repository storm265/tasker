import 'package:flutter/material.dart';

class ColorLineWidget extends StatelessWidget {
  final Color color;
  const ColorLineWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
          width: 120,
          height: 4,
          child: ColoredBox(color: color),
        ),
    );
  }
}
