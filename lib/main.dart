import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_proxy/http_proxy.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_in_page.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_up_page.dart';
import 'package:todo2/presentation/pages/auth/welcome/welcome_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/new_task.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_status.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/system_service/system_chrome.dart';
import 'services/theme_service/theme_data_controller.dart';

Future<void> setNetwork() async {
  final info = NetworkInfo();

  var wifiName = await info.getWifiName();
  log('wifiName $wifiName');
  if (kReleaseMode) {
    if (wifiName == "COGNITEQ") {
      HttpProxy httpProxy = await HttpProxy.createHttpProxy();
      httpProxy.host = "10.101.4.108";
      httpProxy.port = "8888";
      HttpOverrides.global = httpProxy;
    } else {
      // TODO home network

    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SystemChromeProvider.setSystemChrome();
  await setNetwork();
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
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Todo2',
          theme: _themeDataController.themeData,
          initialRoute: '/',
          routes: routes,
        // home: SignUpPage(),
        ),
      ),
    );
  }
}
