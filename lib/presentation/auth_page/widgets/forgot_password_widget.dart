import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final Size size;
  const ForgotPasswordWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: size.width * 0.62,
        top: size.height * 0.60,
        child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/forgotPassword'),
            child: const Text('Forgot password',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic))));
  }
}
