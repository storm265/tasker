import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../supabase/auth_state.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends AuthState<SplashPage> {
  @override
  void initState() {
    super.initState();
    recoverSupabaseSession();
  }

  @override
  void onReceivedAuthDeeplink(Uri uri) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
