import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  @override
  void onUnauthenticated() async {
    await NavigationService.navigateTo(context, Pages.signIn);
  }
}
