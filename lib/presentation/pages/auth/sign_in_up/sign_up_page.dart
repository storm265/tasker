

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_up_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/padding_contstant.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/avatar_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/activity_indicator_widget.dart';
import 'package:todo2/services/dependency_service/dependency_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final _signUpController = getIt<SignUpController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _signUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      showLeadingButton: true,
      isRedAppBar: false,
      isCustomRoute: true,
      navRoute: Pages.welcome,
      child: DisabledGlowWidget(
        child: SingleChildScrollView(
          child: UnfocusWidget(
            child: Form(
              key: _signUpController.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(paddingAll),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 20,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleTextWidget(text: LocaleKeys.welcome.tr()),
                          const SizedBox(height: 6),
                          SubTitleWidget(
                            text: LocaleKeys.sign_up_to_continue.tr(),
                          ),
                        ],
                      ),
                    ),
                    AvatarWidget(
                      imgController: _signUpController.fileController,
                    ),
                    TextFieldWidget(
                      validateCallback: (text) => _signUpController
                          .formValidatorController
                          .validateEmail(email: text!),
                      isEmail: false,
                      textController: _emailController,
                      labelText: LocaleKeys.email.tr(),
                      title: LocaleKeys.email.tr(),
                    ),
                    TextFieldWidget(
                      validateCallback: (text) => _signUpController
                          .formValidatorController
                          .validatePassword(
                        password: text!,
                        isSignIn: false,
                      ),
                      isEmail: false,
                      isObcecure: true,
                      textController: _passwordController,
                      labelText: LocaleKeys.enter_your_password.tr(),
                      title: LocaleKeys.password.tr(),
                    ),
                    TextFieldWidget(
                      validateCallback: (text) => _signUpController
                          .formValidatorController
                          .validateNickname(username: text!),
                      isEmail: false,
                      textController: _usernameController,
                      isObcecure: false,
                      labelText: LocaleKeys.username.tr(),
                      title: LocaleKeys.username.tr(),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _signUpController.isActiveSignUpButton,
                      builder: (context, isClicked, _) => isClicked
                          ? SubmitUpButtonWidget(
                              buttonText: LocaleKeys.sign_up.tr(),
                              onPressed: isClicked
                                  ? () async => _signUpController.trySignUp(
                                        context: context,
                                        userName: _usernameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      )
                                  : null,
                            )
                          : ActivityIndicatorWidget(
                              text: LocaleKeys.validating.tr(),
                            ),
                    ),
                    SignButtonWidget(
                      buttonText: LocaleKeys.sign_in.tr(),
                      isSignInPage: true,
                    ),
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
