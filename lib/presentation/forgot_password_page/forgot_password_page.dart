import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/auth_page/widgets/arrow_back_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/textfield_widget.dart';
import 'package:todo2/presentation/auth_page/widgets/welcome_text_widget.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ArrowBackWidget(size: _size, left: 0.070, top: 0.040),
          TitleTextWidget(
              size: _size, text: 'Forgot Password', left: 0.088, top: 0.29),
          SignUpToContinueWidget(
              left: 0.095,
              top: 0.40,
              size: _size,
              text:
                  'Please enter your email below to recevie\nyour password reset instructions'),
          TextFieldWidget(
            isObsecureText: false,
            textController: _emailController,
            size: _size,
            left: 0.1,
            top: 0.37,
            labelText: 'Email:',
            text: 'Username',
          ),
          //             Supabase.instance.client.from('users').select('email');
          SignUpButtonWidget(
              onPressed: () async {
                await Supabase.instance.client.auth.api
                    .resetPasswordForEmail(_emailController.text)
                    .then((_) => Navigator.pushReplacementNamed(
                        context, '/newPassword'));
              },
              size: _size,
              buttonText: 'Send Request',
              height: 0.55),
        ],
      ),
    );
  }
}
