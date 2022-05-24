import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart' as supabase;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
  }

  @override
  void onAuthenticated(supabase.Session session) {
    Navigator.pushNamedAndRemoveUntil(context, '/workList', (route) => false);
  }

  @override
  void onPasswordRecovery(supabase.Session session) {}

  @override
  void onErrorAuthenticating(String message) {}
}
