import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/welcome_text_widget.dart';
import 'package:todo2/presentation/widgets/changed_password_page/text_decorations.dart';

class PasswordChangedPage extends StatelessWidget {
  PasswordChangedPage({Key? key}) : super(key: key);
  final _passwordDecorations = TextDecorations();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 160,
            left: 120,
            child: Image.asset(_passwordDecorations.assetsPath),
          ),
          TitleTextWidget(
            text: _passwordDecorations.resetPassword,
            left: 135,
          ),
          SubTitleWidget(
            text: _passwordDecorations.passwordChangedText,
            left: 50,
          )
        ],
        fit: StackFit.expand,
        alignment: Alignment.center,
      ),
    );
  }
}
