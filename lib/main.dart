import 'package:flutter/material.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_attachment_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/tasks_member_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/supabase/configure.dart';
import 'package:todo2/services/supabase/update_token_service.dart';
import 'package:todo2/services/system_service/system_chrome.dart';
import 'presentation/pages/menu_pages/floating_button/new_note/new_note_page.dart';
import 'presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'presentation/pages/menu_pages/profile/controller/inherited_profile.dart';
import 'services/theme_service/theme_data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChromeProvider.setSystemChrome();
  await initSupabase();
  await updateToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _newTaskConroller = AddTaskController(
    tasksMembers: TasksMembersRepositoryImpl(),
    taskRepository: TaskRepositoryImpl(),
    projectRepository: ProjectRepositoryImpl(),
    userProfileRepository: UserProfileRepositoryImpl(),
    taskAttachment: TaskAttachmentRepositoryImpl(),
  );

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
          //  initialRoute: '/',
           // routes: routes,
              home: AddQuickNote(),
          ),
        ),
      ),
    );
  }
}
