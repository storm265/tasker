import 'package:flutter/material.dart';
import 'package:todo2/controller/auth/form_validator_controller.dart';
import 'package:todo2/controller/auth/auth_controller.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/constants.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/avatar_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/textfield_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/welcome_text_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _signUpController.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final SignUpController _signUpController = SignUpController();
  final _formValidatorController = FormValidatorController();
  final _formKey = GlobalKey<FormState>();
  final double _leftPadding = 25;
  bool _isClickedSubmitButton = true;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return WillPopWrapper(
      child: Scaffold(
        appBar:  AppbarWidget(
          shouldUsePopMethod: true,
          showLeadingButton: true,
          appBarColor: Colors.white,
          brightness: Brightness.dark,
        ),
        body: DisabledGlowWidget(
          child: SingleChildScrollView(
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
                    const TitleTextWidget(text: 'Welcome'),
                    const SubTitleWidget(text: 'Sign up to continue'),
                    AvatarWidget(signUpController: _signUpController),
                    TextFieldWidget(
                        validateCallback: (text) =>
                            _formValidatorController.validateEmail(text!),
                        isObsecureText: false,
                        textController: _emailController,
                        left: _leftPadding,
                        top: 190,
                        labelText: 'Email:',
                        text: 'Email'),
                    TextFieldWidget(
                      validateCallback: (text) =>
                          _formValidatorController.validatePassword(text!),
                      isObsecureText: true,
                      textController: _passwordController,
                      left: _leftPadding,
                      top: 280,
                      labelText: 'Password:',
                      text: 'Password',
                    ),
                    TextFieldWidget(
                      validateCallback: (text) =>
                          _formValidatorController.validateUsername(text!),
                      isObsecureText: false,
                      textController: _usernameController,
                      left: _leftPadding,
                      top: 380,
                      labelText: 'Username:',
                      text: 'Username',
                    ),
                    SignUpButtonWidget(
                        buttonText: 'Sign Up',
                        height: 470,
                        onPressed: _isClickedSubmitButton
                            ? () async {
                                if (_formKey.currentState!.validate() &&
                                    !_signUpController.pickedFile.value.path
                                        .contains('assets')) {
                                  setState(() => _isClickedSubmitButton = false);
                                  await _signUpController.signUp(
                                    context: context,
                                    username: _usernameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  setState(() => _isClickedSubmitButton = true);
                                }
                              }
                            : null),
                               _isClickedSubmitButton ? const CircularProgressIndicator.adaptive() : const SizedBox(),
                    const SignInButtonWidget(buttonText: 'Sign In')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
