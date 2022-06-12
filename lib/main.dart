import 'package:flutter/material.dart';
import 'package:todo2/controller/main/system_chrome_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_checklist_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note_page.dart';
import 'package:todo2/presentation/pages/auth_pages/sign_in_page.dart';
import 'package:todo2/presentation/pages/auth_pages/sign_up_page.dart';
import 'package:todo2/services/supabase/splash_page.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';
import 'package:todo2/presentation/pages/menu_pages/tasks_page.dart';
import 'package:todo2/services/supabase/configure.dart';
import 'controller/main/theme_data_controller.dart';
import 'presentation/pages/auth_pages/changed_password_page.dart';
import 'presentation/pages/auth_pages/forgot_password_page.dart';
import 'presentation/pages/menu_pages/floating_button/new_task.dart';
import 'presentation/pages/no_connection_page.dart';
import 'presentation/pages/auth_pages/reset_password_page.dart';
import 'presentation/pages/auth_pages/welcome_page.dart';

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
  final _themeDataController = ThemeDataController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo2',
        theme: _themeDataController.themeData,
        initialRoute: '/',
       
        routes: {
          '/': (_) => const SplashPage(),
          '/noConnection': (_) => const NoConnectionPage(),
          '/welcome': (_) => const WelcomePage(),
          '/signUp': (_) => const SignUpPage(),
          '/signIn': (_) => const SignInPage(),
          '/forgotPassword': (_) => const ForgotPasswordPage(),
          '/newPassword': (_) => NewPasswordPage(),
          '/passwordChanged': (_) => PasswordChangedPage(),
          '/home': (_) => NavigationPage(),
          '/workList': (_) => const TasksPage(),
          '/addTask': (_) => NewTaskPage(),
          '/addNote': (_) => AddQuickNote(),
          '/addCheckList': (_) => const AddCheckListPage()
        });
  }
}
