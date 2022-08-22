import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_in_page.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_up_page.dart';
import 'package:todo2/presentation/pages/auth/splash_page.dart';
import 'package:todo2/presentation/pages/auth/welcome/welcome_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/add_checklist_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/new_note_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/new_task.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/profile_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/presentation/pages/navigation/navigation_page.dart';
import 'package:todo2/presentation/pages/no_connection_page.dart';
import 'package:todo2/services/navigation_service/pages.dart';

// TODO: please, use new syntax of enum to make them possible to hold String values. You will be able to delete pages.dart file
enum Pages {
  welcome,
  signUp,
  signUpReplacement,
  signIn,
  signInReplacement,
  navigationReplacement,
  tasks,
  menu,
  quick,
  profile,
  noConnection,
  addNote,
  addCheckList,
  addTask
}

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => const SplashPage(),
  navigation: (_) => const NavigationPage(),
  noConnection: (_) => const NoConnectionPage(),
  welcome: (_) => const WelcomePage(),
  signUp: (_) => const SignUpPage(),
  signIn: (_) => const SignInPage(),
  tasks: (_) => const TasksPage(),
  menu: (_) => const MenuPage(),
  quick: (_) => QuickPage(),
  profile: (_) => const ProfilePage(),
  addTask: (_) => const AddTaskPage(),
  addNote: (_) => const AddQuickNote(),
  addCheckList: (_) => const AddCheckListPage()
};

class NavigationService {
  static Future<void> navigateTo(
    BuildContext context,
    Pages page,
  ) async {
    switch (page) {
      case Pages.welcome:
        await Navigator.pushNamedAndRemoveUntil(
            context, welcome, ((_) => false));
        break;

      case Pages.navigationReplacement:
        await Navigator.pushReplacementNamed(context, navigation);
        break;

      case Pages.signUp:
        await Navigator.pushNamed(context, signUp);
        break;

      case Pages.signUpReplacement:
        await Navigator.pushReplacementNamed(context, signUp);
        break;

      case Pages.signIn:
        await Navigator.pushNamed(context, signIn);
        break;

      case Pages.signInReplacement:
        await Navigator.pushReplacementNamed(context, signIn);
        break;

      case Pages.tasks:
        await Navigator.pushNamed(context, tasks);
        break;

      case Pages.menu:
        await Navigator.pushNamed(context, menu);
        break;

      case Pages.quick:
        await Navigator.pushNamed(context, quick);
        break;

      case Pages.profile:
        await Navigator.pushNamed(context, profile);
        break;

      case Pages.noConnection:
        await Navigator.pushNamed(context, noConnection);
        break;

      case Pages.addCheckList:
        await Navigator.pushNamed(context, addCheckList);
        break;

      case Pages.addNote:
        await Navigator.pushNamed(context, addNote);
        break;

      case Pages.addTask:
        await Navigator.pushNamed(context, addTask);
        break;
    }
  }
}
