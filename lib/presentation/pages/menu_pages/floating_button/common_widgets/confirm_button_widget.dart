import 'package:flutter/material.dart';
import 'package:todo2/utils/theme_util.dart';

class ConfirmButtonWidget extends StatelessWidget {
  const ConfirmButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color = Palette.red,
    this.width = 295,
    this.height = 48,
    this.useAlign = false,
  }) : super(key: key);

  final double width;

  final double height;

  final String title;

  final Color color;

  final bool useAlign;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(width: 5.0, color: color),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
