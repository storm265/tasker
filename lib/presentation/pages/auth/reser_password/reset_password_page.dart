import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/pages/auth/reser_password/controller/restore_password_controller.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _restorePasswordController = RestorePasswordController();

  @override
  void dispose() {
    _restorePasswordController.passwordController1.dispose();
    _restorePasswordController.passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdatePassword = ModalRoute.of(context)!.settings.arguments;
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        shouldUsePopMethod: true,
        showLeadingButton: true,
        appBarColor: Colors.white,

        // TODO maybe a problem
        // resizeToAvoidBottomInset: false,
        child: isUpdatePassword == true
            ? StreamBuilder(
                stream: SupabaseAuth.instance.onAuthChange,
                builder: (_, AsyncSnapshot<AuthChangeEvent> snapshot) {
                  if (snapshot.data == AuthChangeEvent.passwordRecovery) {
                    return Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        const TitleTextWidget(text: 'Reset Password'),
                        const SubTitleWidget(
                            text:
                                'Reset code was sent to your email. Please\nenter the code and creae new password'),
                        TextFieldWidget(
                          validateCallback: null,
                          isObsecureText: true,
                          textController:
                              _restorePasswordController.passwordController1,
                          left: 25,
                          top: 150,
                          labelText: 'Enter your password',
                          text: 'New password',
                        ),
                        TextFieldWidget(
                          validateCallback: null,
                          isObsecureText: true,
                          textController:
                              _restorePasswordController.passwordController2,
                          left: 25,
                          top: 250,
                          labelText: 'Enter your confirm password',
                          text: 'Confirm password',
                        ),
                        SignUpButtonWidget(
                          buttonText: 'Change password',
                          height: 350,
                          onPressed: () => _restorePasswordController
                              .validatePassword(context),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Confirm email'),
                        ],
                      ),
                    );
                  }
                },
              )
            : Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  const TitleTextWidget(text: 'New Password'),
                  TextFieldWidget(
                    validateCallback: null,
                    isObsecureText: true,
                    textController:
                        _restorePasswordController.passwordController1,
                    left: 25,
                    top: 150,
                    labelText: 'Enter new password',
                    text: 'New password',
                  ),
                  TextFieldWidget(
                    validateCallback: null,
                    isObsecureText: true,
                    textController:
                        _restorePasswordController.passwordController2,
                    left: 25,
                    top: 250,
                    labelText: 'Enter your confirm password',
                    text: 'Confirm password',
                  ),
                  SignUpButtonWidget(
                    buttonText: 'Update password',
                    height: 350,
                    onPressed: () =>
                        _restorePasswordController.validatePassword(context),
                  ),
                ],
              ),
      ),
    );
  }
}
