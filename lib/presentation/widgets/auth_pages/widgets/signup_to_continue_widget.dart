import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final String? text;
  final double left;
  final double top;
  const SubTitleWidget({
    Key? key,
    this.text,
    this.left = 25,
    this.top = 40, //160
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
