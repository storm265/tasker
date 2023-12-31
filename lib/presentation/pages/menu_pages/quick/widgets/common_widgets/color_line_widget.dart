import 'package:flutter/material.dart';

class ColorLineWidget extends StatelessWidget {
  final Color color;
  const ColorLineWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 17,
      child: SizedBox(
        width: 121,
        height: 3,
        child: ColoredBox(color: color),
      ),
    );
  }
}
