import 'package:flutter/material.dart';
import 'package:todo2/presentation/menu_page.dart';
import 'package:todo2/presentation/profile_page.dart';
import 'package:todo2/presentation/quick_page.dart';
import 'package:todo2/presentation/tasks_page.dart';
import 'package:todo2/presentation/work_list/widgets/floatin_button_widget.dart';
import 'package:todo2/presentation/work_list/widgets/nav_bar_items.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  late final _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      TasksPage(
        tabController: _tabController,
      ),
      ProfilePage(),
      QuickPage(),
      MenuPage()
    ];
    int pageIndex = 0;
    return Scaffold(
        floatingActionButton: const FloatingButtonWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            items: [
              ...navBarItems,
            ],
            onTap: (index) {
              print(index);
              setState(() {
                pageIndex = index;
                _pageController.animateToPage(pageIndex,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutExpo);
              });
            },
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed),
        body: PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            itemBuilder: (context, _) {
              return pages[pageIndex];
            }));
  }
}
