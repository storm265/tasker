import 'package:flutter/material.dart';
import 'package:todo2/controller/auth/auth_controller.dart';
import 'package:todo2/controller/auth/form_validator_controller.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/constants.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/forgot_password_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/textfield_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/welcome_text_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInController = SignUpController();
  final _formValidatorController = FormValidatorController();
  final _formKey = GlobalKey<FormState>();
  final double _left = 25;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isClicked = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppbarWidget(
        showLeadingButton: true,
        appBarColor: Colors.white,
      ),
      body: DisabledGlowScrollView(
        child: SizedBox(
          width: _size.width - minFactor,
          height: _size.height - minFactor,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                const TitleTextWidget(text: 'Welcome back'),
                const SubTitleWidget(text: 'Sign in to continue'),
                TextFieldWidget(
                  validateCallback: (text) =>
                      _formValidatorController.validateEmail(text!),
                  isObsecureText: false,
                  textController: _emailController,
                  left: _left,
                  top: 120,
                  labelText: 'Email:',
                  text: 'Username',
                ),
                TextFieldWidget(
                  validateCallback: (text) =>
                      _formValidatorController.validatePassword(text!),
                  isObsecureText: true,
                  textController: _passwordController,
                  left: _left,
                  top: 220,
                  labelText: 'Password:',
                  text: 'Password',
                ),
                SignUpButtonWidget(
                    buttonText: 'Sign In',
                    height: 380,
                    onPressed: _isClicked
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isClicked = false);
                              await _signInController.signIn(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              setState(() => _isClicked = true);
                            }
                          }
                        : null),
                const SignInButtonWidget(buttonText: 'Sign Up'),
                const ForgotPasswordWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
