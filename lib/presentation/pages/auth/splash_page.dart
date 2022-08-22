import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

import 'package:todo2/storage/secure_storage_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late SecureStorageService _secureStorageService;
  bool isAuth = false;
  @override
  void initState() {
    _secureStorageService = SecureStorageService();
    // TODO: why you need Delay here?
    Future.delayed(Duration.zero, () async => isAuthenticated());
    super.initState();
  }

  Future<void> isAuthenticated() async {
    final accessToken = await _secureStorageService.getUserData(
        type: StorageDataType.accessToken);
    await Future.delayed(
      const Duration(seconds: 1),
      () async => NavigationService.navigateTo(context,
          accessToken == null ? Pages.welcome : Pages.navigationReplacement),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapperWidget(
      isRedAppBar: false,
      child: Center(
        child: Image.asset('assets/splash_screen/splash.png'),
      ),
    );
  }
}
