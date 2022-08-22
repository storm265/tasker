import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/profile_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/presentation/pages/navigation/widgets/keep_page_alive.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

// TODO add  more  pages,
class NavigationController extends ChangeNotifier {
  final pageIndex = ValueNotifier<int>(0);

  late PageController pageController;

  final List<Widget> pages = [
    const KeepAlivePageWidget(child: TasksPage()),
    const KeepAlivePageWidget(child: MenuPage()),
    KeepAlivePageWidget(child: QuickPage()),
    const KeepAlivePageWidget(child: ProfilePage()),
  ];

  Future<void> pushToPage(Pages page) async {
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
      default:
        pageIndex.value = 0;
        break;
    }
    pageIndex.notifyListeners();
    pageController.jumpToPage(pageIndex.value);
  }
}
