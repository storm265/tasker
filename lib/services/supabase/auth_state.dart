import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
// TODO should refactor
class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() async {
    await NavigationService.navigateTo(context, Pages.welcome);
  }

  @override
  void onAuthenticated(Session session) async {
    await NavigationService.navigateTo(context, Pages.home);
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {}
}
