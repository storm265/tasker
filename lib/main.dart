import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_proxy/http_proxy.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/repository/comment_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/new_task.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_status.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/system_service/system_chrome.dart';
import 'package:todo2/storage/secure_storage_service.dart';
import 'presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';
import 'presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'services/theme_service/theme_data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SystemChromeProvider.setSystemChrome();
  if (kReleaseMode) {
    HttpProxy httpProxy = await HttpProxy.createHttpProxy();
    httpProxy.host = "10.101.4.108"; // replace with your server ip
    httpProxy.port = "8888"; // replace with your server port
    HttpOverrides.global = httpProxy;
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AddTaskController _newTaskConroller;
  late final ThemeDataService _themeDataController;
  late final NavigationController _navigationController;
  late final StatusBarController _statusBarController;

  @override
  void initState() {
    _navigationController = NavigationController();
    _statusBarController = StatusBarController();
    _newTaskConroller = AddTaskController(
      tasksMembers: TasksMembersRepositoryImpl(),
      taskRepository: TaskRepositoryImpl(),
      userProfileRepository: UserProfileRepositoryImpl(
        userProfileDataSource: UserProfileDataSourceImpl(
          network: NetworkSource(),
          secureStorageService: SecureStorageSource(),
        ),
      ),
    );
    _themeDataController = ThemeDataService();
    super.initState();
  }

  @override
  void dispose() {
    _newTaskConroller.disposeAll();
    _newTaskConroller.dispose();
    _navigationController.disposeValues();
    _navigationController.dispose();
    _statusBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedStatusBar(
      statusBarController: _statusBarController,
      child: NavigationInherited(
        navigationController: _navigationController,
        child: InheritedNewTaskController(
          addTaskController: _newTaskConroller,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo2',
            theme: _themeDataController.themeData,
          //   initialRoute: '/',
           //  routes: routes,
            home: MenuPage(),
          ),
        ),
      ),
    );
  }
}
