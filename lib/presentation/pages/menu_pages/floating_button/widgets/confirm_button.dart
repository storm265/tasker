import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color color;
  final VoidCallback? onPressed;
  const ConfirmButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color = Palette.red,
    this.width = 295,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height), primary: color),
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
