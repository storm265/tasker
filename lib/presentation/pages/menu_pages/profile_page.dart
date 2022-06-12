import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/profile_page/widgets/panel_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/profile_page/widgets/stats_widget/circle_painter.dart';
import 'package:todo2/presentation/widgets/menu_pages/profile_page/widgets/stats_widget/cut_circle_painter.dart';
import 'package:todo2/presentation/widgets/menu_pages/profile_page/widgets/task_list_widgets/task_list_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Profiles', appBarColor: Colors.white),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const PanelWidget(),
          TaskListWidget(),
          CustomPaint(size: const Size(60, 60), painter: CirclePainter()),
        ],
      ),
    );
  }
}
