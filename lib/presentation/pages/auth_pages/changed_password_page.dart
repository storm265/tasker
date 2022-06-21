import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/welcome_text_widget.dart';

class PasswordChangedPage extends StatelessWidget {
  const PasswordChangedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 160,
            left: 120,
            child: Image.asset('assets/changed_password.png'),
          ),
          const TitleTextWidget(
            text: 'Succesful!',
            left: 135,
          ),
          const SubTitleWidget(
            text:
                'You have succesfully change password.\nPlease use your new passwords when logging in.',
            left: 50,
          )
        ],
      ),
    );
  }
}
