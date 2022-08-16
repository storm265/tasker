import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/storage/avatar_storage_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/storage/avatar_storage_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_up_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/padding_contstant.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/constants.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/avatar_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_in_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final _signUpController = SignUpController(
    authRepository: AuthRepositoryImpl(),
    imagePickerController: ImageController(
      avatarRepository: AvatarStorageReposiroryImpl(
        avatarDataSource: AvatarStorageDataSourceImpl(),
      ),
    ),
    formValidatorController: FormValidatorController(),
    storageSource: SecureStorageSource(),
  );
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _signUpController.disposeValues();
    _signUpController.dispose();
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
                            children: const [
                              TitleTextWidget(text: 'Welcome'),
                              SubTitleWidget(text: 'Sign up to continue'),
                            ],
                          ),
                        ),
                        AvatarWidget(
                            imageController:
                                _signUpController.imagePickerController),
                        TextFieldWidget(
                          validateCallback: (text) => _signUpController
                              .formValidatorController
                              .validateEmail(email: text!),
                          isEmail: false,
                          textController: _emailController,
                          labelText: 'Email:',
                          text: 'Email',
                        ),
                        TextFieldWidget(
                          validateCallback: (text) => _signUpController
                              .formValidatorController
                              .validatePassword(password: text!),
                          isEmail: false,
                          isObcecure: true,
                          textController: _passwordController,
                          labelText: 'Password:',
                          text: 'Password',
                        ),
                        TextFieldWidget(
                          validateCallback: (text) => _signUpController
                              .formValidatorController
                              .validateNickname(username: text!),
                          isEmail: false,
                          textController: _usernameController,
                          isObcecure: false,
                          labelText: 'Username:',
                          text: 'Username',
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable:
                              _signUpController.isActiveSubmitButton,
                          builder: (context, isClicked, _) => isClicked
                              ? SubmitUpButtonWidget(
                                  buttonText: 'Sign Up',
                                  onPressed: isClicked
                                      ? () async =>
                                          _signUpController.signUpValidate(
                                            context: context,
                                            userName: _usernameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          )
                                      : null,
                                )
                              : const ProgressIndicatorWidget(
                                  text: 'Validating...'),
                        ),
                        const SignInButtonWidget(buttonText: 'Sign In'),
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
