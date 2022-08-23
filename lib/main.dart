import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_attachment_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/tasks_member_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/profile_page.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/system_service/system_chrome.dart';
import 'package:todo2/storage/secure_storage_service.dart';
import 'presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'presentation/pages/menu_pages/profile/controller/inherited_profile.dart';
import 'services/theme_service/theme_data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SystemChromeProvider.setSystemChrome();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _newTaskConroller.disposeAll();
    _newTaskConroller.dispose();
    _profileController.dispose();
    super.dispose();
  }

  final _newTaskConroller = AddTaskController(
    tasksMembers: TasksMembersRepositoryImpl(),
    taskRepository: TaskRepositoryImpl(),
    userProfileRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        secureStorageService: SecureStorageService(),
      ),
    ),
    taskAttachment: TaskAttachmentRepositoryImpl(),
  );

  final _themeDataController = ThemeDataService();
  final _profileController = ProfileController(
    secureStorageService: SecureStorageService(),
    tokenStorageService: SecureStorageService(),
    authRepository: AuthRepositoryImpl(),
    userProfileRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        secureStorageService: SecureStorageService(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ProfileInherited(
      profileController: _profileController,
      child: InheritedNewTaskController(
        addTaskController: _newTaskConroller,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo2',
          theme: _themeDataController.themeData,
          initialRoute: '/',
          routes: routes,
          //  home: ProfilePage(),
        ),
      ),
    );
  }
}
