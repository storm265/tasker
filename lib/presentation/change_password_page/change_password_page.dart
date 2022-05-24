import 'package:flutter/material.dart';
import 'package:todo2/presentation/auth_page/widgets/welcome_text_widget.dart';
import 'package:todo2/presentation/change_password_page/text_decorations.dart';

import '../auth_page/widgets/signup_to_continue_widget.dart';

class PasswordChanged extends StatelessWidget {
  PasswordChanged({Key? key}) : super(key: key);
  final _passwordDecorations = TextDecorations();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: _size.height * 0.20,
          left: _size.width * 0.25,
          child: Image.asset(_passwordDecorations.assetsPath)),
      TitleTextWidget(
          size: _size,
          text: _passwordDecorations.resetPassword,
          left: 0.25,
          top: 0.80),
      SignUpToContinueWidget(
          left: 0.095,
          top: 0.95,
          size: _size,
          text: _passwordDecorations.passwordChangedText)
    ], fit: StackFit.expand, alignment: Alignment.center));
  }
}
