import 'package:flutter/material.dart';
import 'package:todo2/presentation/colors.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 20,
        top: 25,
        child: CircleAvatar(
            radius: 20,
            backgroundColor: menuColors[0].withOpacity(0.4),
            child: CircleAvatar(radius: 10, backgroundColor: menuColors[0])));
  }
}
