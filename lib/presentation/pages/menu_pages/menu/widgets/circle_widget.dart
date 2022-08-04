import 'package:flutter/material.dart';

class DoubleCircleWidget extends StatelessWidget {
  final Color color;
  const DoubleCircleWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.4),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: color,
        ),
      );
  }
}
