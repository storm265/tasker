import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String text;
  const TitleTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 25,
        top: 120,
        child: Text(text,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic)));
  }
}
