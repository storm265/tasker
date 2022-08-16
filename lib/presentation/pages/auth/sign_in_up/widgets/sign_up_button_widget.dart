import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class SubmitUpButtonWidget extends StatelessWidget {
  final String buttonText;
  final Alignment alignment;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  const SubmitUpButtonWidget({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.alignment = Alignment.center,
    this.backgroundColor = Palette.red,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          fixedSize: MaterialStateProperty.all(
            const Size(380, 50),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
