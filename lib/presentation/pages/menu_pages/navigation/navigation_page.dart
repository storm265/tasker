// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/add_checklist_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/new_note_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/new_task.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/profile_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/floating_button_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/nav_bar_widget.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
   final _statusBarController = StatusBarController();

   @override
  void dispose() {
    _statusBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    final inheritedNavigatorConroller =
        InheritedNavigator.of(context)!.navigationController;
    return ValueListenableBuilder(
      valueListenable: _statusBarController.isRedStatusBar,
      builder: (context, isRed, _) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: (isRed == true) ? redStatusBar : lightStatusBar,
        child: Scaffold(
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
            maintainBottomViewPadding: true,
            bottom: false,
            child: PageView(
              controller: inheritedNavigatorConroller.pageController,
              children: [
                const KeepAlivePage(child: TasksPage()),
                const KeepAlivePage(child: MenuPage()),
                KeepAlivePage(child: QuickPage()),
                const KeepAlivePage(child: ProfilePage()),
                const NewTaskPage(),
                const AddQuickNote(),
                const AddCheckListPage(),
              ],
            ),
          ),
          bottomNavigationBar: ColoredBox(
            color: const Color(0xFF292E4E),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ValueListenableBuilder(
                valueListenable: inheritedNavigatorConroller.pageIndex,
                builder: (context, pageIndex, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await inheritedNavigatorConroller
                            .animateToPage(NavigationPages.tasks);
                       _statusBarController.setRedStatusMode(true);
                      },
                      child: NavBarItem(
                        label: 'Tasks',
                        icon: 'tasks',
                        iconColor: pageIndex == 0 ? Colors.white : Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await inheritedNavigatorConroller
                            .animateToPage(NavigationPages.menu);
                        _statusBarController.setRedStatusMode(false);
                      },
                      child: NavBarItem(
                        label: 'Menu',
                        icon: 'menu',
                        iconColor: pageIndex == 1 ? Colors.white : Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await inheritedNavigatorConroller
                            .animateToPage(NavigationPages.quick);
                       _statusBarController.setRedStatusMode(false);
                      },
                      child: NavBarItem(
                        label: 'Quick',
                        icon: 'quick',
                        iconColor: pageIndex == 2 ? Colors.white : Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await inheritedNavigatorConroller
                            .animateToPage(NavigationPages.profile);
                        _statusBarController.setRedStatusMode(false);
                      },
                      child: NavBarItem(
                        label: 'Profile',
                        icon: 'profile',
                        iconColor: pageIndex == 3 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;
  const KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  KeepAlivePageState createState() => KeepAlivePageState();
}

class KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
