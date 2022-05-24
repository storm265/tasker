import 'package:flutter/material.dart';

class SignUpButtonWidget extends StatelessWidget {
  final Size size;
  final String buttonText;
  final double height;
  final VoidCallback onPressed;
  const SignUpButtonWidget(
      {Key? key,
      required this.size,
      required this.onPressed,
      required this.buttonText,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size.height * height,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                fixedSize: MaterialStateProperty.all(const Size(380, 50))),
            onPressed: onPressed,
            child: Text(buttonText,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                    color: Colors.white))));
  }
}
