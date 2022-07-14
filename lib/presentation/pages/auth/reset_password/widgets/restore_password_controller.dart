import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/pages/auth/reset_password/controller/restore_password_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class RestorePasswordWidget extends StatelessWidget {
  final RestorePasswordController restoreController;
  const RestorePasswordWidget({Key? key, required this.restoreController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        shouldUsePopMethod: true,
        showLeadingButton: true,
        isRedAppBar: false,
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: StreamBuilder(
              stream: SupabaseAuth.instance.onAuthChange,
              builder: (_, AsyncSnapshot<AuthChangeEvent> snapshot) {
                if (snapshot.data == AuthChangeEvent.passwordRecovery) {
                  return Wrap(
                    runSpacing: 25,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TitleTextWidget(text: 'Reset Password'),
                            SubTitleWidget(
                                text:
                                    'Reset code was sent to your email. Please\nenter the code and create new password'),
                          ],
                        ),
                      ),
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
                      SubmitUpButtonWidget(
                        buttonText: 'Change password',
                        onPressed: () => restoreController.validatePassword(
                            context: context),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: ProgressIndicatorWidget(text: 'Confirm email'),
                  );
                }
              },
            )),
      ),
    );
  }
}
