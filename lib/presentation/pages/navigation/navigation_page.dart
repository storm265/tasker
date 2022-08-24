import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/floating_button_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/nav_bar_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late StatusBarController _statusBarController;
  late NavigationController _navigationController;

  @override
  void initState() {
    _statusBarController = StatusBarController();
    _navigationController = NavigationController();
    _navigationController.pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _navigationController.pageController.dispose();
    _navigationController.dispose();
    _statusBarController.dispose();
    super.dispose();
  }

  final _greyColor = const Color(0xff8E8E93);

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
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _navigationController.pages.length,
                controller: _navigationController.pageController,
                onPageChanged: (index) => _navigationController.pages[index],
                itemBuilder: (_, i) => _navigationController.pages[i]),
          ),
          bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: _navigationController.pageIndex,
            builder: (context, pageIndex, _) => Container(
              height: 60,
              width: double.infinity,
              color: const Color(0xFF292E4E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavBarItem(
                    onTap: () async {
                      _statusBarController.setRedStatusMode(true);
                      await _navigationController.pushToPage(Pages.tasks);
                    },
                    label: 'My Tasks',
                    icon: 'tasks',
                    iconColor: pageIndex == 0 ? Colors.white : _greyColor,
                  ),
                  NavBarItem(
                    onTap: () async {
                      _statusBarController.setRedStatusMode(false);
                      await _navigationController.pushToPage(Pages.menu);
                    },
                    label: 'Menu',
                    icon: 'menu',
                    iconColor: pageIndex == 1 ? Colors.white : _greyColor,
                  ),
                  const SizedBox(width: 50),
                  NavBarItem(
                    onTap: () async {
                      _statusBarController.setRedStatusMode(false);
                      await _navigationController.pushToPage(Pages.quick);
                    },
                    label: 'Quick',
                    icon: 'quick',
                    iconColor: pageIndex == 2 ? Colors.white : _greyColor,
                  ),
                  NavBarItem(
                    onTap: () async {
                      _statusBarController.setRedStatusMode(false);
                      await _navigationController.pushToPage(Pages.profile);
                    },
                    label: 'Profile',
                    icon: 'profile',
                    iconColor: pageIndex == 3 ? Colors.white : _greyColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
