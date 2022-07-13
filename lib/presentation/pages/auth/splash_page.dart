import 'package:flutter/material.dart';
import 'package:todo2/services/network_service/network_service.dart';
import 'package:todo2/services/supabase/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends AuthState<SplashPage> {
  @override
  void initState() {
    super.initState();
    NetworkService().checkConnection(context, () => recoverSupabaseSession());
  }

  @override
  void onReceivedAuthDeeplink(Uri uri) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_screen/splash.png'),
      ),
    );
  }
}
