import 'package:flutter/material.dart';

// TODO fix it
final pageController = PageController(keepPage: true);

enum NavigationPages {
  tasks,
  menu,
  quick,
  profile,
  addNewTask,
  addQuickNote,
  addCheckList,
}

class NavigationController extends ChangeNotifier {
  final pageIndex = ValueNotifier<int>(0);

  Future<void> animateToPage(NavigationPages page) async {
    switch (page) {
      case NavigationPages.tasks:
        pageIndex.value = 0;
        break;
      case NavigationPages.menu:
        pageIndex.value = 1;

        break;
      case NavigationPages.quick:
        pageIndex.value = 2;
        break;
      case NavigationPages.profile:
        pageIndex.value = 3;
        break;

      default:
        pageIndex.value = 0;
        break;
    }

    await pageController.animateToPage(
      pageIndex.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}
