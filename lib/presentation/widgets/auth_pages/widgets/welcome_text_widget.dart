import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String? text;
  final double left;
  final double top;
  const TitleTextWidget({
    Key? key,
    this.left = 25,
    this.text,
    this.top = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
