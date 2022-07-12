import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final String? text;
  const SubTitleWidget({
    Key? key,
    this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
