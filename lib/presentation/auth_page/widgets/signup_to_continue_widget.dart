import 'package:flutter/material.dart';

class SignUpToContinueWidget extends StatelessWidget {
  final Size size;
  final String text;
  final double left, top;
  const SignUpToContinueWidget(
      {Key? key,
      required this.size,
      required this.text,
      required this.left,
      required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: size.width * left, // 0.095,
        top: size.width * top, // 0.40,
        child: Text(text,
            style: const TextStyle(fontSize: 16, color: Colors.black54)));
  }
}
