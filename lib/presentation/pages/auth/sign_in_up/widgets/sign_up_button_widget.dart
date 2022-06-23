import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class SignUpButtonWidget extends StatelessWidget {
  final String buttonText;
  final double? height;
  final VoidCallback? onPressed;
  const SignUpButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Palette.red),
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
