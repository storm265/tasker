import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/supabase/configure.dart';
import 'package:todo2/services/system_service/system_chrome.dart';
import 'services/theme_service/theme_data_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChromeProvider.setSystemChrome();
  await initSupabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeDataController = ThemeDataService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo2',
        theme: _themeDataController.themeData,
        initialRoute: '/',
        // home: SignInPage(),
        routes: routes);
  }
}
