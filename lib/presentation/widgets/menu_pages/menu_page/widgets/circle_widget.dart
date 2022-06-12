import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final String color;
  const CircleWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 25,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Color(int.parse(color)).withOpacity(0.4),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: Color(int.parse(color)),
        ),
      ),
    );
  }
}
