import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/checklist_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/note_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/add_task_page.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/detailed_page.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/profile_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class NavigationController extends ChangeNotifier {
  final pageIndex = ValueNotifier<int>(0);

  final pageController = PageController(
    initialPage: 0,
    keepPage: false,
  );

  final List<Widget> pages = [
    const TasksPage(),
    const MenuPage(),
    const QuickPage(),
    const ProfilePage(),
    const AddEditTaskPage(),
    const AddQuickNote(),
    const CheckListPage(),
    const DetailedPage(),
  ];

  Future<void> moveToPage(Pages page) async {
    switch (page) {
      case Pages.tasks:
        pageIndex.value = 0;
        break;
      case Pages.menu:
        pageIndex.value = 1;
        break;
      case Pages.quick:
        pageIndex.value = 2;
        break;
      case Pages.profile:
        pageIndex.value = 3;
        break;
      case Pages.addTask:
        pageIndex.value = 4;
        break;
      case Pages.addNote:
        pageIndex.value = 5;
        break;
      case Pages.addCheckList:
        pageIndex.value = 6;
        break;
      case Pages.detailedProject:
        pageIndex.value = 7;
        break;
      default:
        pageIndex.value = 0;
        break;
    }
    pageIndex.notifyListeners();
    pageController.jumpToPage(pageIndex.value);
  }
}
