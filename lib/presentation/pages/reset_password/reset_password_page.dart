import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/arrow_back_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/textfield_widget.dart';
import 'package:todo2/presentation/pages/auth_pages/widgets/welcome_text_widget.dart';
import 'package:todo2/services/supabase/configure.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({Key? key}) : super(key: key);
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
            stream: SupabaseAuth.instance.onAuthChange,
            builder: (_, AsyncSnapshot<AuthChangeEvent> snapshot) {
              if (snapshot.hasData == AuthChangeEvent.passwordRecovery) {
                return Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      const ArrowBackWidget(),
                      const TitleTextWidget(text: 'Reset Password'),
                      const SubTitleWidget(
                          text:
                              'Reset code was sent to your email. Please\nenter the code and creae new password'),
                      TextFieldWidget(
                          isObsecureText: true,
                          textController: _passwordController1,
                          left: 25,
                          top: 250,
                          labelText: 'Enter your password',
                          text: 'New password'),
                      TextFieldWidget(
                          isObsecureText: true,
                          textController: _passwordController2,
                          left: 25,
                          top: 350,
                          labelText: 'Enter your confirm password',
                          text: 'Confirm password'),
                      SignUpButtonWidget(
                          buttonText: 'Change password',
                          height: 450,
                          onPressed: () async {
                            if (_passwordController1.text ==
                                    _passwordController2.text &&
                                _passwordController1.text.length > 6) {
                              final res = await supabase.auth.api
                                  .updateUser(
                                      supabase.auth.currentSession!.accessToken,
                                      UserAttributes(
                                          password: _passwordController1.text))
                                  .then((_) => Navigator.pushReplacementNamed(
                                      context, '/passwordChanged'));
                            }
                          })
                    ]);
              } else {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                      CircularProgressIndicator(),
                      Text('Confirm email')
                    ]));
              }
            }));
  }
}
