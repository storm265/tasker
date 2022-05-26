import 'package:flutter/material.dart';
import 'package:todo2/controller/main_controller/theme_data_controller.dart';
import 'package:todo2/controller/main_controller/system_chrome_controller.dart';
import 'package:todo2/presentation/pages/change_password_page/password_changed_page.dart';
import 'package:todo2/presentation/pages/splash_screen.dart';
import 'package:todo2/services/supabase/configure.dart';
import 'presentation/pages/auth_pages/sign_in_page.dart';
import 'presentation/pages/auth_pages/sign_up_page.dart';
import 'presentation/pages/forgot_password_page/forgot_password_page.dart';
import 'presentation/pages/reset_password/reset_password_page.dart';
import 'presentation/pages/welcome_page/welcome_page.dart';
import 'presentation/pages/work_list/navigation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChromeProvider().setSystemChrome();
  await initSupabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext _) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo2',
        theme: ThemeDataController().themeData,
        initialRoute: '/',
        routes: {
          '/': (_) => SplashPage(), // NavigationPage(),
          '/welcome': (_) => const WelcomePage(),
          '/signUp': (_) => SignUpPage(),
          '/signIn': (_) => SignInPage(),
          '/forgotPassword': (_) => ForgotPasswordPage(),
          '/newPassword': (_) => NewPasswordPage(),
          '/passwordChanged': (context) => PasswordChanged(),
          '/workList': (_) => const NavigationPage()
        });
  }
}
