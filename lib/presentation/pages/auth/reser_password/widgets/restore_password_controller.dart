import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/pages/auth/reser_password/controller/restore_password_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';

class RestorePasswordWidget extends StatelessWidget {
  final RestorePasswordController restoreController;
  const RestorePasswordWidget({Key? key, required this.restoreController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Wrap(
                  runSpacing: 25,
                  children: [
                    TextFieldWidget(
                      validateCallback: null,
                      isEmail: true,
                      textController: restoreController.passwordController1,
                      labelText: 'Enter your password',
                      text: 'New password',
                    ),
                    TextFieldWidget(
                      validateCallback: null,
                      isEmail: true,
                      textController: restoreController.passwordController2,
                      labelText: 'Enter your confirm password',
                      text: 'Confirm password',
                    ),
                  ],
                ),
              ),
              SignUpButtonWidget(
                buttonText: 'Change password',
                height: 350,
                onPressed: () =>
                    restoreController.validatePassword(context: context),
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator.adaptive(),
                Text('Confirm email'),
              ],
            ),
          );
        }
      },
    );
  }
}
