import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final TextDecoration? textDecoration;
  const TitleWidget({
    Key? key,
    required this.title,
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            decoration: textDecoration,
            fontWeight: FontWeight.w200,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
