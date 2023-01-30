// ignore_for_file: prefer_final_fields

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_status.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/services/dependency_service/dependency_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/refresh_token_controller.dart';
import 'package:todo2/services/system_service/system_chrome.dart';
import 'services/theme_service/theme_data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.defaultLevel == DiagnosticLevel.hidden;
  setupDependencies();
  await dotenv.load(fileName: '.env');
  await SystemChromeProvider.setSystemChrome();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/localization',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeDataController = ThemeDataService();
  final _navigationController = NavigationController();
  final _statusBarController = StatusBarController();

  @override
  void dispose() {
    _navigationController.dispose();
    _statusBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedStatusBar(
      statusBarController: _statusBarController,
      child: NavigationInherited(
        navigationController: _navigationController,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Todo2',
          theme: _themeDataController.themeData,
          initialRoute: '/',
          routes: routes,
        ),
      ),
    );
  }
}
