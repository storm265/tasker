import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class SignInButtonWidget extends StatelessWidget {
  final String buttonText;
  const SignInButtonWidget({Key? key, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () async => (buttonText == 'Sign In')
            ? await NavigationService.navigateTo(
                context, Pages.signInReplacement)
            : await NavigationService.navigateTo(
                context, Pages.signUpReplacement),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Palette.red,
          ),
        ),
      ),
    );
  }
}
