import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Text(
            text!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          )
        : const SizedBox();
  }
}
