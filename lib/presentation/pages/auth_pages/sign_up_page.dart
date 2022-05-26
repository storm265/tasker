import 'package:flutter/material.dart';
import 'package:todo2/controller/auth/sign_up_controller.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/arrow_back_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/avatar_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/signup_to_continue_widget.dart';
import 'widgets/sign_up_button_widget.dart';
import 'widgets/textfield_widget.dart';
import 'widgets/welcome_text_widget.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController _signUpController = SignUpController();
  SignUpPage({Key? key}) : super(key: key);
  final double _left = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
        const ArrowBackWidget(),
        const TitleTextWidget(text: 'Welcome'),
        const SubTitleWidget(text: 'Sign up to continue'),
        AvatarWidget(),
        TextFieldWidget(
            isObsecureText: false,
            textController: _signUpController.emailController,
            left: _left,
            top: 320,
            labelText: 'Email:',
            text: 'Username'),
        TextFieldWidget(
            isObsecureText: true,
            textController: _signUpController.passwordController,
            left: _left,
            top: 420,
            labelText: 'Password:',
            text: 'Password'),
        SignUpButtonWidget(
            buttonText: 'Sign Up',
            height: 550,
            onPressed: () => _signUpController.signUp(context)),
        const SignInButtonWidget(buttonText: 'Sign In')
      ]),
    );
  }
}
