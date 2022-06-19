import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final VoidCallback? onPressed;
  const ConfirmButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.width = 295,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: Size(width, height)),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),
      ),
    );
  }
}
