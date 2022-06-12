import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  @override
  void onUnauthenticated() async {
    /// Users will be sent back to the LoginPage if they sign out.
    if (mounted) {
      /// Users will be sent back to the LoginPage if they sign out.
      await NavigationService.navigateTo(context, Pages.signIn);
    }
  }
}
