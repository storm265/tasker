import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/changed_password_page.dart';
import 'package:todo2/presentation/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:todo2/presentation/pages/auth/reser_password/reset_password_page.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_in_page.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_up_page.dart';
import 'package:todo2/presentation/pages/auth/splash_page.dart';
import 'package:todo2/presentation/pages/auth/welcome/welcome_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/add_checklist_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/new_note_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/new_task.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/navigation_page.dart';
import 'package:todo2/presentation/pages/no_connection_page.dart';

enum Pages {
  welcome,
  signUp,
  signIn,
  forgotPassword,
  newPassword,
  passwordChanged,
  updatePassword,
  home,
  taskList,
  noConnection,
  addNote,
  addCheckList,
  addTask
}

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => const SplashPage(),
  '/noConnection': (_) => const NoConnectionPage(),
  '/welcome': (_) => const WelcomePage(),
  '/signUp': (_) => const SignUpPage(),
  '/signIn': (_) => const SignInPage(),
  '/forgotPassword': (_) => const ForgotPasswordPage(),
  '/newPassword': (_) => const NewPasswordPage(),
  '/passwordChanged': (_) => const PasswordChangedPage(),
  '/home': (_) => const NavigationPage(),
  '/taskList': (_) => const TasksPage(),
  '/addTask': (_) => const AddTaskPage(),
  '/addNote': (_) => const AddQuickNote(),
  '/addCheckList': (_) => const AddCheckListPage()
};

class NavigationService {
  static Future<void> navigateTo(BuildContext context, Pages page,
      {Object? arguments}) async {
    switch (page) {
      case Pages.welcome:
        Navigator.pushNamedAndRemoveUntil(context, '/welcome', ((_) => false));
        break;
      case Pages.signUp:
        Navigator.pushNamed(context, '/signUp');
        break;
      case Pages.signIn:
        Navigator.pushNamed(context, '/signIn');
        break;
      case Pages.forgotPassword:
        Navigator.pushNamed(context, '/forgotPassword');
        break;
      case Pages.newPassword:
        Navigator.pushNamed(context, '/newPassword');
        break;
      case Pages.passwordChanged:
        Navigator.pushNamedAndRemoveUntil(
            context, '/passwordChanged', ((_) => false));
        break;
      case Pages.updatePassword:
        Navigator.pushNamed(context, '/updatePassword', arguments: arguments);
        break;
      case Pages.taskList:
        Navigator.pushNamed(context, '/workList');
        break;
      case Pages.home:
        Navigator.pushNamed(context, '/home');
        break;
      case Pages.noConnection:
        Navigator.pushNamed(context, '/noConnection');
        break;
      case Pages.addCheckList:
        Navigator.pushNamed(context, '/addCheckList');
        break;
      case Pages.addNote:
        Navigator.pushNamed(context, '/addNote');
        break;
      case Pages.addTask:
        Navigator.pushNamed(context, '/addTask');
        break;
    }
  }
}
