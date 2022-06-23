import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 245,
      top: 315,
      child: InkWell(
        onTap: () async =>
            await NavigationService.navigateTo(context, Pages.forgotPassword),
        child: const Text(
          'Forgot password',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
