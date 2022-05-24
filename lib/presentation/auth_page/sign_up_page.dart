import 'package:flutter/material.dart';
import 'package:todo2/controller/auth/sign_up_controller.dart';
import 'package:todo2/presentation/auth_page/widgets/arrow_back_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/avatar_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/signup_to_continue_widget.dart';

import 'widgets/sign_up_button_widget.dart';
import 'widgets/textfield_widget.dart';
import 'widgets/welcome_text_widget.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController _signUpController = SignUpController();
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ArrowBackWidget(size: _size, left: 0.070, top: 0.080),
          TitleTextWidget(size: _size, text: 'Welcome', left: 0.088, top: 0.29),
          SignUpToContinueWidget(
              size: _size, text: 'Sign up to continue', left: 0.095, top: 0.40),
          AvatarWidget(size: _size),
          TextFieldWidget(
              isObsecureText: false,
              textController: _signUpController.emailController,
              size: _size,
              left: 0.1,
              top: 0.45,
              labelText: 'Email:',
              text: 'Username'),
          TextFieldWidget(
              isObsecureText: true,
              textController: _signUpController.passwordController,
              size: _size,
              left: 0.1,
              top: 0.60,
              labelText: 'Password:',
              text: 'Password'),
          SignUpButtonWidget(
              size: _size,
              buttonText: 'Sign Up',
              height: 0.77,
              onPressed: () => _signUpController.signUp(context)),
          SignInButtonWidget(size: _size, buttonText: 'Sign In')
        ],
      ),
    );
  }
}
