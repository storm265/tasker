import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/reser_password/controller/padding_constant.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_in_controller.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/constants.dart';
import 'package:todo2/presentation/pages/auth/forgot_password/widgets/forgot_password_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

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
        child: DisabledGlowWidget(
          child: SingleChildScrollView(
            child: UnfocusWidget(
              child: SizedBox(
                width: size.width - minFactor,
                height: size.height - minFactor,
                child: Form(
                  key: _signInController.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.all(paddingAll),
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        const TitleTextWidget(text: 'Welcome back'),
                        const SubTitleWidget(text: 'Sign in to continue'),
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Wrap(
                            runSpacing: 25,
                            children: [
                              TextFieldWidget(
                                validateCallback: (text) => _signInController
                                    .formValidatorController
                                    .validateEmail(email: text!),
                                isEmail: false,
                                textController: _emailController,
                                labelText: 'Email:',
                                text: 'Username',
                              ),
                              TextFieldWidget(
                                validateCallback: (text) => _signInController
                                    .formValidatorController
                                    .validatePassword(password: text!),
                                isEmail: false,
                                textController: _passwordController,
                                isObcecure: true,
                                labelText: 'Password:',
                                text: 'Password',
                              ),
                            ],
                          ),
                        ),
                        const ForgotPasswordWidget(),
                        ValueListenableBuilder<bool>(
                          valueListenable:
                              _signInController.isClickedSubmitButton,
                          builder: ((context, isClicked, _) =>
                              SubmitUpButtonWidget(
                                buttonText: 'Sign In',
                                top: 170,
                                onPressed: isClicked
                                    ? () async {
                                        _signInController.signInValidate(
                                          context: context,
                                          emailController:
                                              _emailController.text,
                                          passwordController:
                                              _passwordController.text,
                                        );
                                      }
                                    : null,
                              )),
                        ),
                        const SignInButtonWidget(
                          buttonText: 'Sign Up',
                          bottom: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
