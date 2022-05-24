import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/auth_page/widgets/arrow_back_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/textfield_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/welcome_text_widget.dart';
import 'package:todo2/supabase/configure.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
      ArrowBackWidget(size: _size, left: 0.070, top: 0.090),
      TitleTextWidget(
          size: _size, text: 'Reset Password', left: 0.088, top: 0.29),
      SignUpToContinueWidget(
          left: 0.095,
          top: 0.40,
          size: _size,
          text:
              'Reset code was sent to your email. Please\nenter the code and creae new password'),
      TextFieldWidget(
          isObsecureText: false,
          textController: _numberController,
          size: _size,
          left: 0.1,
          top: 0.37,
          labelText: 'Enter your number',
          text: 'Reset code'),
      TextFieldWidget(
          isObsecureText: true,
          textController: _passwordController,
          size: _size,
          left: 0.1,
          top: 0.52,
          labelText: 'Enter your password',
          text: 'New password'),
      TextFieldWidget(
          isObsecureText: true,
          textController: _passwordController,
          size: _size,
          left: 0.1,
          top: 0.67,
          labelText: 'Enter your confirm password',
          text: 'Confirm password'),
      SignUpButtonWidget(
          onPressed: () {
            Supabase.instance.client.auth.api
                .updateUser(
                  supabaseAnnonKey,
                  UserAttributes(password: _passwordController.text),
                )
                .then((value) => print(value.statusCode));
          },
          size: _size,
          buttonText: 'Change password',
          height: 0.82)
    ]));
  }
}
