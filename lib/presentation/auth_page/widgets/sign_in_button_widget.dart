import 'package:flutter/material.dart';

class SignInButtonWidget extends StatelessWidget {
  final Size size;
  final String buttonText;
  const SignInButtonWidget(
      {Key? key, required this.size, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.87,
      child: TextButton(
        onPressed: () {
          if (buttonText == 'Sign In') {
            Navigator.pushNamed(context, '/signIn');
          } else {
            Navigator.pushNamed(context, '/signUp');
          }
        },
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
