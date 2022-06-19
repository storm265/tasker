import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart' as supabase;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() async {
    // final _prefs = await SharedPreferences.getInstance();
    // if (_prefs.getBool('isFirstTime') == null) {
    //   await _prefs.setBool('isFirstTime', true);
    //   await NavigationService.navigateTo(context, Pages.welcome);
    // } else {
    //   await NavigationService.navigateTo(context, Pages.signIn);
    // }
    await NavigationService.navigateTo(context, Pages.welcome);
  }

  @override
  void onAuthenticated(supabase.Session session) async {
    await NavigationService.navigateTo(context, Pages.home);
  }

  @override
  void onPasswordRecovery(supabase.Session session) {}

  @override
  void onErrorAuthenticating(String message) {}
}
