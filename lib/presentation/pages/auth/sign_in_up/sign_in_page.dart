import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_in_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/padding_contstant.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/constants.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signInController = SignInController(
    userController: UserController(
      userProfileRepository: UserProfileRepositoryImpl(
        userProfileDataSource: UserProfileDataSourceImpl(
          network: NetworkSource(),
          secureStorageService: SecureStorageSource(),
        ),
      ),
    ),
    storageSource: SecureStorageSource(),
    authRepository: AuthRepositoryImpl(),
    formValidatorController: FormValidatorController(),
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppbarWrapWidget(
      showLeadingButton: true,
      isRedAppBar: false,
      resizeToAvoidBottomInset: false,
      child: UnfocusWidget(
        child: SizedBox(
          width: size.width - minFactor,
          height: size.height - minFactor,
          child: Form(
            key: _signInController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(paddingAll),
              child: Wrap(
                runSpacing: 25,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextWidget(
                          text: LocaleKeys.welcome_back.tr(),
                        ),
                        const SizedBox(height: 6),
                        SubTitleWidget(
                            text: LocaleKeys.sign_in_to_continue.tr()),
                      ],
                    ),
                  ),
                  TextFieldWidget(
                    validateCallback: (text) => _signInController
                        .formValidatorController
                        .validateEmail(email: text!),
                    isEmail: false,
                    textController: _emailController,
                    labelText: LocaleKeys.email.tr(),
                    title: LocaleKeys.email.tr(),
                  ),
                  TextFieldWidget(
                    validateCallback: (text) => _signInController
                        .formValidatorController
                        .validatePassword(password: text!),
                    isEmail: false,
                    textController: _passwordController,
                    isObcecure: true,
                    labelText: LocaleKeys.enter_your_password.tr(),
                    title: LocaleKeys.password.tr(),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _signInController.isActiveSubmitButton,
                    builder: ((context, isClicked, _) => isClicked
                        ? SubmitUpButtonWidget(
                            buttonText: LocaleKeys.sign_in.tr(),
                            onPressed: isClicked
                                ? () async {
                                    _signInController.tryToSignIn(
                                      context: context,
                                      emailController: _emailController.text,
                                      passwordController:
                                          _passwordController.text,
                                    );
                                  }
                                : null,
                          )
                        : ProgressIndicatorWidget(
                            text: LocaleKeys.validating.tr(),
                          )),
                  ),
                  SignButtonWidget(
                    buttonText: LocaleKeys.sign_up.tr(),
                    isSignInPage: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
