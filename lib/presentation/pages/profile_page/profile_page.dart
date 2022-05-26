import 'package:flutter/material.dart';
import 'package:todo2/presentation/appbar_widget.dart';
import 'package:todo2/presentation/pages/profile_page/widgets/panel_widget.dart';
import 'package:todo2/presentation/pages/profile_page/widgets/task_list_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarWidget(title: 'Profiles'),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [PanelWidget(), TaskListWidget()]));
  }
}
