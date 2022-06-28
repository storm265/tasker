import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/inherited_profile.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/stats_widget/stats_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/task_list_widgets/task_list_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inheritedProfile = ProfileInherited.of(context);
    return AppbarWrapperWidget(
      title: 'Profiles',
      appBarColor: Colors.white,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const ProfileWidget(),
            FutureBuilder<List<ProjectModel>>(
              initialData: const [],
              future: inheritedProfile.profileController.fetchProfile(),
              builder: (_, AsyncSnapshot<List<ProjectModel>> snapshot) {
                return snapshot.hasData
                    ? Column(
                        children: [
                          TaskListWidget(snapshot: snapshot),
                          StatsWidget(snapshot: snapshot),
                        ],
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
