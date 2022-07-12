import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class SignInButtonWidget extends StatelessWidget {
  final String buttonText;
  final double bottom;
  const SignInButtonWidget(
      {Key? key, required this.buttonText, this.bottom = 470})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () async => (buttonText == 'Sign In')
              ? await NavigationService.navigateTo(context, Pages.signIn)
              : await NavigationService.navigateTo(context, Pages.signUp),
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
      ),
    );
  }
}
