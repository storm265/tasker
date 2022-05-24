import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size(double.infinity, 90);
  final TabController tabController;
  const CustomAppBar({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.tune_outlined),
          ),
        ],
        centerTitle: true,
        title: const Text('Work list',
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20)),
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(child: Text('Today', style: TextStyle(fontSize: 18))),
          Tab(child: Text('Month', style: TextStyle(fontSize: 18)))
        ]));
  }
}
