import 'package:flutter/material.dart';
import 'package:todo2/controller/auth/sign_in_controller.dart';
import 'package:todo2/presentation/auth_page/widgets/arrow_back_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/forgot_password_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/textfield_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/welcome_text_widget.dart';

class SignInPage extends StatelessWidget {
  final _signInController = SignInController();
  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
      ArrowBackWidget(size: _size, left: 0.070, top: 0.07),
      TitleTextWidget(size: _size, text: 'Welcome', left: 0.088, top: 0.29),
      SignUpToContinueWidget(
        size: _size,
        text: 'Sign in to continue',
        left: 0.095,
        top: 0.40,
      ),
      TextFieldWidget(
        isObsecureText: false,
        textController: _signInController.emailController,
        size: _size,
        left: 0.1,
        top: 0.32,
        labelText: 'Email:',
        text: 'Username',
      ),
      TextFieldWidget(
        isObsecureText: true,
        textController: _signInController.passwordController,
        size: _size,
        left: 0.1,
        top: 0.47,
        labelText: 'Password:',
        text: 'Password',
      ),
      SignUpButtonWidget(
          onPressed: () => _signInController.signIn(context),
          size: _size,
          buttonText: 'Sign In',
          height: 0.68),
      SignInButtonWidget(size: _size, buttonText: 'Sign Up'),
      ForgotPasswordWidget(size: _size)
    ]));
  }
}
