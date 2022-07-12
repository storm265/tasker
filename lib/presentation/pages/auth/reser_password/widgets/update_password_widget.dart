import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/reser_password/controller/restore_password_controller.dart';
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
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        const TitleTextWidget(text: 'New Password'),
        const SubTitleWidget(
            text:
                'Reset code was sent to your email. Please enter the code and creae new password'),
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Wrap(
            runSpacing: 25,
            children: [
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
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: restoreController.isClickedSubmit,
          builder: (_, isClicked, __) => SubmitUpButtonWidget(
            buttonText: 'Update password',
            top: 200,
            onPressed: isClicked
                ? () => restoreController.validatePassword(context: context)
                : null,
          ),
        )
      ],
    );
  }
}
