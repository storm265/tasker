import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String text;
  const HeaderWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
