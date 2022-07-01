import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/reser_password/reset_password_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/profile_page.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/navigation_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/supabase/configure.dart';
import 'package:todo2/services/system_service/system_chrome.dart';
import 'presentation/pages/menu_pages/floating_button/new_note/new_note_page.dart';
import 'presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'presentation/pages/menu_pages/floating_button/new_task/new_task.dart';
import 'presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'presentation/pages/menu_pages/profile/controller/inherited_profile.dart';
import 'services/theme_service/theme_data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChromeProvider.setSystemChrome();
  await initSupabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
final _newTaskConroller = AddTaskController();
  final _themeDataController = ThemeDataService();
  final _profileController = ProfileController();
  final _navigationController = NavigationController();
  @override
  Widget build(BuildContext context) {
    return InheritedNavigator(
      navigationController: _navigationController,
      child: ProfileInherited(
        profileController: _profileController,
        child: InheritedNewTaskController(
          addTaskController: _newTaskConroller,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo2',
            theme: _themeDataController.themeData,
           initialRoute: '/',
              routes: routes,
          //  home: NewTaskPage(),
          ),
        ),
      ),
    );
  }
}
