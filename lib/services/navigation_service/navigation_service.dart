import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_in_page.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/sign_up_page.dart';
import 'package:todo2/presentation/pages/auth/splash/splash_page.dart';
import 'package:todo2/presentation/pages/auth/welcome/welcome_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/checklist_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/note_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/add_task_page.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/detailed_page.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/profile_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/presentation/pages/navigation/navigation_page.dart';

enum Pages {
  welcome('welcome'),
  signUp('signUp'),
  signUpReplacement('signUpReplacement'),
  signIn('signIn'),
  signInReplacement('signInReplacement'),
  navigationReplacement('navigationReplacement'),
  tasks('tasks'),
  menu('menu'),
  quick('quick'),
  profile('profile'),
  noConnection('noConnection'),
  addNote('addNote'),
  addCheckList('addCheckList'),
  addTask('addTask'),
  detailedProject('detailedProject');

  final String type;
  const Pages(this.type);
}

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => SplashPage(),
  Pages.navigationReplacement.type: (_) => const NavigationPage(),
  Pages.welcome.type: (_) => const WelcomePage(),
  Pages.signUp.type: (_) => const SignUpPage(),
  Pages.signIn.type: (_) => const SignInPage(),
  Pages.tasks.type: (_) => const TasksPage(),
  Pages.menu.type: (_) => const MenuPage(),
  Pages.quick.type: (_) => const QuickPage(),
  Pages.profile.type: (_) => const ProfilePage(),
  Pages.addTask.type: (_) => const AddEditTaskPage(),
  Pages.addNote.type: (_) => const AddQuickNote(),
  Pages.addCheckList.type: (_) => const CheckListPage(),
  Pages.detailedProject.type: (_) => const DetailedPage(),
};

class NavigationService {
  static Future<void> navigateTo(
    BuildContext context,
    Pages page,
  ) async {
    switch (page) {
      case Pages.welcome:
        await Navigator.pushNamed(context, Pages.welcome.type);
        break;

      case Pages.navigationReplacement:
        await Navigator.pushNamedAndRemoveUntil(
            context, Pages.navigationReplacement.type, ((_) => false));
        break;

      case Pages.signUp:
        await Navigator.pushNamed(context, Pages.signUp.type);
        break;

      case Pages.signUpReplacement:
        await Navigator.pushReplacementNamed(context, Pages.signUp.type);
        break;

      case Pages.signIn:
        await Navigator.pushNamed(context, Pages.signIn.type);
        break;

      case Pages.signInReplacement:
        await Navigator.pushReplacementNamed(context, Pages.signIn.type);
        break;

      case Pages.tasks:
        await Navigator.pushNamed(context, Pages.tasks.type);
        break;

      case Pages.menu:
        await Navigator.pushNamed(context, Pages.menu.type);
        break;

      case Pages.quick:
        await Navigator.pushNamed(context, Pages.quick.type);
        break;

      case Pages.profile:
        await Navigator.pushNamed(context, Pages.profile.type);
        break;

      case Pages.noConnection:
        await Navigator.pushNamed(context, Pages.noConnection.type);
        break;

      case Pages.addCheckList:
        await Navigator.pushNamed(context, Pages.addCheckList.type);
        break;

      case Pages.addNote:
        await Navigator.pushNamed(context, Pages.addNote.type);
        break;

      case Pages.addTask:
        await Navigator.pushNamed(context, Pages.addTask.type);
        break;

      case Pages.detailedProject:
        await Navigator.pushNamed(context, Pages.detailedProject.type);
        break;
    }
  }
}
