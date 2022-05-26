import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/welcome_text_widget.dart';
import 'package:todo2/presentation/pages/change_password_page/text_decorations.dart';

import '../auth_pages/widgets/signup_to_continue_widget.dart';

class PasswordChanged extends StatelessWidget {
  PasswordChanged({Key? key}) : super(key: key);
  final _passwordDecorations = TextDecorations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: 160,
          left: 120,
          child: Image.asset(_passwordDecorations.assetsPath)),
      TitleTextWidget(
          text: _passwordDecorations.resetPassword), // left: 140, top: 360
      SubTitleWidget(
         text: _passwordDecorations.passwordChangedText)
    ], fit: StackFit.expand, alignment: Alignment.center));
  }
}
