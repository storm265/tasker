import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_in_controller.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/constants.dart';
import 'package:todo2/presentation/pages/auth/forgot_password/widgets/forgot_password_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signInController = SignInController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signInController.isClickedSubmitButton.dispose();
    _signInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        shouldUsePopMethod: true,
        showLeadingButton: true,
          isRedAppBar: false,
        // statusBarColor: Colors.white,
        child: DisabledGlowWidget(
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width - minFactor,
              height: size.height - minFactor,
              child: Form(
                key: _signInController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    const TitleTextWidget(text: 'Welcome back'),
                    const SubTitleWidget(text: 'Sign in to continue'),
                    TextFieldWidget(
                      validateCallback: (text) => _signInController
                          .formValidatorController
                          .validateEmail(text!),
                      isObsecureText: false,
                      textController: _emailController,
                      left: _signInController.left,
                      top: 120,
                      labelText: 'Email:',
                      text: 'Username',
                    ),
                    TextFieldWidget(
                      validateCallback: (text) => _signInController
                          .formValidatorController
                          .validatePassword(text!),
                      isObsecureText: true,
                      textController: _passwordController,
                      left: _signInController.left,
                      top: 220,
                      labelText: 'Password:',
                      text: 'Password',
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _signInController.isClickedSubmitButton,
                      builder: ((context, isClicked, _) => SignUpButtonWidget(
                            buttonText: 'Sign In',
                            height: 380,
                            onPressed: isClicked
                                ? () async {
                                    _signInController.signInValidate(
                                      context: context,
                                      emailController: _emailController.text,
                                      passwordController:
                                          _passwordController.text,
                                    );
                                  }
                                : null,
                          )),
                    ),
                    const SignInButtonWidget(buttonText: 'Sign Up'),
                    const ForgotPasswordWidget(),
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
