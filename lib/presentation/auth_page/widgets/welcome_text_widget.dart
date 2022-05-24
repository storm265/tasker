import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final Size size;
  final String text;
  final double left, top;
  const TitleTextWidget(
      {Key? key,
      required this.size,
      required this.text,
      required this.left,
      required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: size.width * left,
        top: size.width * top,
        child: Text(text,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic)));
  }
}
