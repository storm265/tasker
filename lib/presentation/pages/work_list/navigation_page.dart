import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_page/menu_page.dart';
import 'package:todo2/presentation/pages/profile_page/profile_page.dart';
import 'package:todo2/presentation/pages/quick_page/quick_page.dart';
import 'package:todo2/presentation/pages/tasks_page.dart';
import 'package:todo2/presentation/pages/work_list/widgets/floating_button_widget.dart';
import 'package:todo2/presentation/pages/work_list/widgets/nav_bar_items.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: const FloatingButtonWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: NavBarItem(
                  icon: 'tasks',
                  iconColor: _pageIndex == 0 ? Colors.white : Colors.grey,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: NavBarItem(
                  icon: 'menu',
                  iconColor: _pageIndex == 1 ? Colors.white : Colors.grey,
                ),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: NavBarItem(
                  icon: 'quick',
                  iconColor: _pageIndex == 2 ? Colors.white : Colors.grey,
                ),
                label: 'Quick',
              ),
              BottomNavigationBarItem(
                icon: NavBarItem(
                  icon: 'profile',
                  iconColor: _pageIndex == 3 ? Colors.white : Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
            onTap: (index) => setState(() => _pageIndex = index),
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed),
        body: SafeArea(
            maintainBottomViewPadding: true,
            bottom: false,
            child: IndexedStack(index: _pageIndex, children: const [
              TasksPage(),
              MenuPage(),
              QuickPage(),
              ProfilePage()
            ])));
  }
}
