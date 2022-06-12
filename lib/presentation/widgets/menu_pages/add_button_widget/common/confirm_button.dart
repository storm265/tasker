import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ConfirmButtonWidget(
      {Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: Colors.white),
        ),
      ),
    );
  }
}
