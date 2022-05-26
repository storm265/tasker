import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 245,
        top: 415,
        child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/forgotPassword'),
            child: const Text('Forgot password',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic))));
  }
}
