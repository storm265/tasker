import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:todo2/presentation/pages/auth/reset_password/controller/padding_constant.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void dispose() {
    _emailController.dispose();
    _forgotPasswordController.dispose();
    _forgotPasswordController.isClickedButton.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final _forgotPasswordController = ForgotPasswordController();
  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        shouldUsePopMethod: true,
        showLeadingButton: true,
        isRedAppBar: false,
        child: Form(
          key: _forgotPasswordController.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: UnfocusWidget(
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
                          TitleTextWidget(text: 'Forgot Password'),
                          SubTitleWidget(
                            text:
                                'Please enter your email below to recevie\nyour password reset instructions',
                          ),
                        ],
                      ),
                    ),
                    TextFieldWidget(
                      validateCallback: (text) => _forgotPasswordController
                          .validatorController
                          .validateEmail(email: text!),
                      isEmail: false,
                      textController: _emailController,
                      labelText: 'Email:',
                      text: 'Username',
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable:
                          _forgotPasswordController.isClickedButton,
                      builder: (context, isClicked, _) => SubmitUpButtonWidget(
                        alignment: Alignment.topCenter,
                        buttonText: 'Send Request',
                        onPressed: isClicked
                            ? () async {
                                await _forgotPasswordController.sendEmail(
                                  context: context,
                                  email: _emailController.text,
                                  navigationCallback: () =>
                                      NavigationService.navigateTo(
                                    context,
                                    Pages.updatePassword,
                                    arguments: true,
                                  ),
                                );
                              }
                            : null,
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
