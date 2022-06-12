import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_checklist_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note_page.dart';
import 'package:todo2/presentation/pages/menu_pages/menu_page.dart';
import 'package:todo2/presentation/pages/menu_pages/profile_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/tasks_page.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/floating_button_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/nav_bar_widget.dart';

final pageController = PageController(initialPage: 0, keepPage: true);

class NavigationPage extends StatelessWidget {
  NavigationPage({Key? key}) : super(key: key);

  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ColoredBox(
        color: const Color(0xFF292E4E),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: StatefulBuilder(
            builder: (_, setState) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    _pageIndex = 0;
                    pageController.jumpToPage(_pageIndex);
                  }),
                  child: NavBarItem(
                      label: 'Tasks',
                      icon: 'tasks',
                      iconColor: _pageIndex == 0 ? Colors.white : Colors.grey),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _pageIndex = 1;
                    pageController.jumpToPage(_pageIndex);
                  }),
                  child: NavBarItem(
                      label: 'Menu',
                      icon: 'menu',
                      iconColor: _pageIndex == 1 ? Colors.white : Colors.grey),
                ),
                const SizedBox(
                  width: 50,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _pageIndex = 2;
                    pageController.jumpToPage(_pageIndex);
                  }),
                  child: NavBarItem(
                      label: 'Quick',
                      icon: 'quick',
                      iconColor: _pageIndex == 2 ? Colors.white : Colors.grey),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _pageIndex = 3;
                    pageController.jumpToPage(_pageIndex);
                  }),
                  child: NavBarItem(
                      label: 'Profile',
                      icon: 'profile',
                      iconColor: _pageIndex == 3 ? Colors.white : Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        bottom: false,
        child: PageView(
          controller: pageController,
          children: [
            const KeepAlivePage(child: TasksPage()),
            const KeepAlivePage(child: MenuPage()),
            const KeepAlivePage(child: QuickPage()),
            const KeepAlivePage(child: ProfilePage()),
      
            NewTaskPage(), AddQuickNote(), AddCheckListPage(),
          ],
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
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
