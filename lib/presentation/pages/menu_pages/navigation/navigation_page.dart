import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/widgets/keep_alive_widget.dart';
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
  late NavigationController inheritedNavigatorConroller;

  @override
  void didChangeDependencies() {
    inheritedNavigatorConroller =
        InheritedNavigator.of(context)!.navigationController;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _statusBarController.dispose();
    super.dispose();
  }

  final Color _greyColor = const Color(0xff8E8E93);
  @override
  Widget build(BuildContext context) {
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
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                index == 0
                    ? _statusBarController.setRedStatusMode(true)
                    : _statusBarController.setRedStatusMode(false);
              },
              controller: pageController,
              children: [
                const KeepAlivePageWidget(child: TasksPage()),
                const KeepAlivePageWidget(child: MenuPage()),
                KeepAlivePageWidget(child: QuickPage()),
                const KeepAlivePageWidget(child: ProfilePage()),
              ],
            ),
          ),
          bottomNavigationBar: ColoredBox(
            color: const Color(0xFF292E4E),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ValueListenableBuilder<int>(
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
                        label: 'My Tasks',
                        icon: 'tasks',
                        iconColor: pageIndex == 0 ? Colors.white : _greyColor,
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
                        iconColor: pageIndex == 1 ? Colors.white : _greyColor,
                      ),
                    ),
                    const SizedBox(width: 50),
                    GestureDetector(
                      onTap: () async {
                        await inheritedNavigatorConroller
                            .animateToPage(NavigationPages.quick);
                        _statusBarController.setRedStatusMode(false);
                      },
                      child: NavBarItem(
                        label: 'Quick',
                        icon: 'quick',
                        iconColor: pageIndex == 2 ? Colors.white : _greyColor,
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
                        iconColor: pageIndex == 3 ? Colors.white : _greyColor,
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
