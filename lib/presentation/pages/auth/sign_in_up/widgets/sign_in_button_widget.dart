import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class SignButtonWidget extends StatelessWidget {
  const SignButtonWidget({
    Key? key,
    required this.buttonText,
    required this.isSignInPage,
  }) : super(key: key);

  final String buttonText;

  final bool isSignInPage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () async => isSignInPage
            ? await NavigationService.navigateTo(context, Pages.signIn)
            : await NavigationService.navigateTo(context, Pages.signIn),
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
