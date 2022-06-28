import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_up_controller.dart';
import 'package:todo2/presentation/widgets/common/annotated_region_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/constants.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/avatar_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
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

  final _signUpController = SignUpController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        shouldUsePopMethod: true,
        showLeadingButton: true,
        appBarColor: Colors.white,
       
        child: DisabledGlowWidget(
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width - minFactor,
              height: size.height - minFactor,
              child: Form(
                key: _signUpController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    const TitleTextWidget(text: 'Welcome'),
                    const SubTitleWidget(text: 'Sign up to continue'),
                    AvatarWidget(signUpController: _signUpController),
                    TextFieldWidget(
                        validateCallback: (text) => _signUpController
                            .formValidatorController
                            .validateEmail(text!),
                        isObsecureText: false,
                        textController: _emailController,
                        left: _signUpController.leftPadding,
                        top: 190,
                        labelText: 'Email:',
                        text: 'Email'),
                    TextFieldWidget(
                      validateCallback: (text) => _signUpController
                          .formValidatorController
                          .validatePassword(text!),
                      isObsecureText: true,
                      textController: _passwordController,
                      left: _signUpController.leftPadding,
                      top: 280,
                      labelText: 'Password:',
                      text: 'Password',
                    ),
                    TextFieldWidget(
                      validateCallback: (text) => _signUpController
                          .formValidatorController
                          .validateUsername(text!),
                      isObsecureText: false,
                      textController: _usernameController,
                      left: _signUpController.leftPadding,
                      top: 380,
                      labelText: 'Username:',
                      text: 'Username',
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _signUpController.isClickedSubmitButton,
                      builder: (context, isClicked, _) => SignUpButtonWidget(
                        buttonText: 'Sign Up',
                        height: 470,
                        onPressed: isClicked
                            ? () async => _signUpController.signUpValidate(
                                  context: context,
                                  userName: _usernameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                )
                            : null,
                      ),
                    ),
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
