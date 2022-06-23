import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/pages/auth/reser_password/controller/restore_password_controller.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({Key? key}) : super(key: key);

  final _restorePasswordController = RestorePasswordController();

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        appBar: const AppbarWidget(
          showLeadingButton: true,
          appBarColor: Colors.white,
        ),
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
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
                    onPressed: () =>
                        _restorePasswordController.validatePassword(context),
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
        ),
      ),
    );
  }
}
