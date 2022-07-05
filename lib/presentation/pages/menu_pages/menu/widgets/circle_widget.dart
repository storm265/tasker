import 'package:flutter/material.dart';

class DoubleCircleWidget extends StatelessWidget {
  final bool isUsePositioned;
  final String color;
  const DoubleCircleWidget({Key? key, required this.color,this.isUsePositioned = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  isUsePositioned ? Positioned(
      left: 20,
      top: 25,
      child:  CircleAvatar(
        radius: 20,
        backgroundColor: Color(int.parse(color)).withOpacity(0.4),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: Color(int.parse(color)),
        ),
      )
    ): CircleAvatar(
        radius: 20,
        backgroundColor: Color(int.parse(color)).withOpacity(0.4),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: Color(int.parse(color)),
        ),
      );
  }
}
