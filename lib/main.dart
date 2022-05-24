import 'package:flutter/material.dart';
import 'package:todo2/supabase/configure.dart';
import 'package:todo2/presentation/splash_screen.dart';
import 'package:todo2/controller/main_controller/system_chrome_controller.dart';
import 'package:todo2/presentation/auth_page/sign_up_page.dart';
import 'package:todo2/presentation/forgot_password_page/forgot_password_page.dart';
import 'package:todo2/presentation/welcome_page/welcome_page.dart';
import 'presentation/auth_page/sign_in_page.dart';
import 'presentation/reset_password/reset_password_page.dart';
import 'presentation/work_list/navigation_page.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => SplashPage(),
        '/welcome': (context) => const WelcomePage(),
        '/signUp': (context) => SignUpPage(),
        '/signIn': (context) => SignInPage(),
        '/forgotPassword': (context) => NewPasswordPage(),
        '/newPassword': (context) => ResetPasswordPage(),
        '/workList': (context) => const NavigationPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Todo2',
      theme: ThemeData(
        useMaterial3: false, // bullshit
        primarySwatch: Colors.red,
        bottomAppBarColor: Colors.red,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF292E4E),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      // home: SafeArea(
      //   maintainBottomViewPadding: true,
      //   bottom: false,
      //   child: SplashPage(),

      // )
    );
  }
}
