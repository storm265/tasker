import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.auth.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

   
    if (response.error != null) {
    } else if (response.data == null && response.user == null) {
      //Please check your email and follow the instructions to verify your email address.

    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/workList',
        (route) => false,
      );
    }
  }
}
