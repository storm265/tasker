import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/reset_password/controller/restore_password_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/subtitle_widget.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';

class UpdatePasswordWidget extends StatelessWidget {
  final RestorePasswordController restoreController;
  const UpdatePasswordWidget({Key? key, required this.restoreController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitleTextWidget(text: 'New Password'),
              SubTitleWidget(
                  text:
                      'Reset code was sent to your email. Please enter the code and create new password'),
            ],
          ),
        ),
        TextFieldWidget(
          validateCallback: null,
          isEmail: true,
          textController: restoreController.passwordController1,
          labelText: 'Enter new password',
          text: 'New password',
        ),
        TextFieldWidget(
          validateCallback: null,
          isEmail: true,
          textController: restoreController.passwordController2,
          labelText: 'Enter your confirm password',
          text: 'Confirm password',
        ),
        ValueListenableBuilder<bool>(
          valueListenable: restoreController.isClickedSubmit,
          builder: (_, isClicked, __) => SubmitUpButtonWidget(
            buttonText: 'Update password',
            onPressed: isClicked
                ? () => restoreController.validatePassword(context: context)
                : null,
          ),
        )
      ],
    );
  }
}
