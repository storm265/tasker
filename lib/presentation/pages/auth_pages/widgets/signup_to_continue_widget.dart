import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final String text;

  const SubTitleWidget(
      {Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 25,
        top: 160,
        child: Text(text,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400)));
  }
}
