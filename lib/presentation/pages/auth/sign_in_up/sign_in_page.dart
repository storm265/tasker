import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
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
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/dynamic_single_scroll.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: put it in Constructor of SignInController
    _signInController.scrollController = ScrollController();
    super.initState();
  }

  final _signInController = SignInController(
    userController: UserController(
      userProfileRepository: UserProfileRepositoryImpl(
        userProfileDataSource: UserProfileDataSourceImpl(
          secureStorageService: SecureStorageService(),
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
    _signInController.disposeObjects();
    _signInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppbarWrapWidget(
      showLeadingButton: true,
      isRedAppBar: false,
      child: DisabledGlowWidget(
        child: ValueListenableBuilder<bool>(
          valueListenable: _signInController.isActiveScrolling,
          builder: (__, isScrolling, _) =>
              DynamicPhycicsSingleChildScrollView(
            scrollController: _signInController.scrollController,
            isActivesScrolling: isScrolling,
            child: UnfocusWidget(
              onClick: () =>
                  _signInController.changeScrollStatus(isActive: false),
              child: SizedBox(
                width: size.width - minFactor,
                height: size.height - minFactor,
                child: Form(
                  key: _signInController.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.all(paddingAll),
                    child: Wrap(
                      runSpacing: 25,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              TitleTextWidget(text: 'Welcome back'),
                              SubTitleWidget(text: 'Sign in to continue'),
                            ],
                          ),
                        ),
                        TextFieldWidget(
                          signInController: _signInController,
                          validateCallback: (text) => _signInController
                              .formValidatorController
                              .validateEmail(email: text!),
                          isEmail: false,
                          textController: _emailController,
                          labelText: 'Email',
                          title: 'Email',
                        ),
                        TextFieldWidget(
                          signInController: _signInController,
                          validateCallback: (text) => _signInController
                              .formValidatorController
                              .validatePassword(password: text!),
                          isEmail: false,
                          textController: _passwordController,
                          isObcecure: true,
                          labelText: 'Enter your password',
                          title: 'Password',
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable:
                              _signInController.isActiveSubmitButton,
                          builder: ((context, isClicked, _) => isClicked
                              ? SubmitUpButtonWidget(
                                  buttonText: 'Sign In',
                                  onPressed: isClicked
                                      ? () async {
                                          _signInController.tryToSignIn(
                                            context: context,
                                            emailController:
                                                _emailController.text,
                                            passwordController:
                                                _passwordController.text,
                                          );
                                        }
                                      : null,
                                )
                              : const ProgressIndicatorWidget(
                                  text: 'Validating...')),
                        ),
                        const SignInButtonWidget(buttonText: 'Sign Up'),
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
