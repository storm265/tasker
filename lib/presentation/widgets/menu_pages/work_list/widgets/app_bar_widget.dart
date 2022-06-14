import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/tasks_dialog.dart';

class AppBarWorkList extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size(double.infinity, 90);
  final TabController tabController;
  const AppBarWorkList({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.red,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Palette.red,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
      leading: const Icon(null),
      actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: const Icon(Icons.tune_outlined),
              onTap: () => showTasksDialog(context),
            ))
      ],
      centerTitle: true,
      title: const Text(
        'Work list',
        style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 20,
        ),
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        controller: tabController,
        tabs: const [
          Tab(
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Month',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
