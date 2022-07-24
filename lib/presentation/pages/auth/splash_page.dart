import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_service.dart';
import 'package:todo2/services/storage/tokens_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  bool isAuth = false;
  @override
  void initState() {
    //NetworkService().checkConnection(context, () => Navigator.pop(context));
    Future.delayed(Duration.zero, () async => isAuthenticated());

    super.initState();
  }

  Future<void> isAuthenticated() async {
    final accessToken = await TokenStorageService().getAccessToken();
    await Future.delayed(
        const Duration(seconds: 1),
        () async => NavigationService.navigateTo(
            context, accessToken == null ? Pages.welcome : Pages.home));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_screen/splash.png'),
      ),
    );
  }
}
