import 'package:flutter/material.dart';
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
  '/home': (_) => const NavigationPage(),
  '/taskList': (_) => const TasksPage(),
  '/addTask': (_) => const AddTaskPage(),
  '/addNote': (_) => const AddQuickNote(),
  '/addCheckList': (_) => const AddCheckListPage()
};

class NavigationService {
  static Future<void> navigateTo(
    BuildContext context,
    Pages page,
  ) async {
    switch (page) {
      case Pages.welcome:
        await Navigator.pushNamedAndRemoveUntil(
            context, '/welcome', ((_) => false));
        break;
      case Pages.signUp:
        await Navigator.pushNamed(context, '/signUp');
        break;
      case Pages.signIn:
        await Navigator.pushNamed(context, '/signIn');
        break;

      case Pages.taskList:
        await Navigator.pushNamed(context, '/workList');
        break;
      case Pages.home:
        await Navigator.pushNamedAndRemoveUntil(
            context, '/home', ((_) => false));
        break;
      case Pages.noConnection:
        await Navigator.pushNamed(context, '/noConnection');
        break;
      case Pages.addCheckList:
        await Navigator.pushNamed(context, '/addCheckList');
        break;
      case Pages.addNote:
        await Navigator.pushNamed(context, '/addNote');
        break;
      case Pages.addTask:
        await Navigator.pushNamed(context, '/addTask');
        break;
    }
  }
}
