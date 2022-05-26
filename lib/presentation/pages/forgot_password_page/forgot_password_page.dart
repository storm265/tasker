import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/arrow_back_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/welcome_text_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
          const ArrowBackWidget(),
          const TitleTextWidget(text: 'Forgot Password'),
          const SubTitleWidget(
              text:
                  'Please enter your email below to recevie\nyour password reset instructions'),
          TextFieldWidget(
              left: 25,
              top: 260,
              isObsecureText: false,
              textController: _emailController,
              labelText: 'Email:',
              text: 'Username'),
          SignUpButtonWidget(
              height: 370,
              buttonText: 'Send Request',
              onPressed: () async => await Supabase.instance.client.auth.api
                  .resetPasswordForEmail(_emailController.text,
                      options: AuthOptions(
                          redirectTo:
                              'io.supabase.flutterquickstart://restore-password/'))
                  .then((_) =>
                      Navigator.pushReplacementNamed(context, '/newPassword')))
        ]));
  }
}
