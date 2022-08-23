import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/inherited_profile.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/stats_widget/stats_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/task_list_widgets/task_list_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/profile_widget.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = UserController(
    userProfileRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        secureStorageService: SecureStorageService(),
      ),
    ),
  );
  StatsModel stats = StatsModel(
    createdTasks: 0,
    completedTasks: 0,
    events: 'events',
    quickNotes: 'quickNotes',
    todo: 'todo',
  );

  Future<void> getData() async {
    stats = await userController.fetchUserStatistics();
  }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inheritedProfile = ProfileInherited.of(context);
    return AppbarWrapperWidget(
      title: 'Profile',
      isRedAppBar: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Wrap(
          children: [
            ProfileWidget(
              profileController: inheritedProfile.profileController,
              //   completedTasks: stats.completedTasks,
              //   createdTask: stats.createdTasks,
              completedTasks: 999,
              createdTask: 999,
            ),
            //  StatsWidget(statsModel: stats),
            // FutureBuilder<List<ProjectModel>>(
            //   initialData: const [],
            //   // future: inheritedProfile.profileController.

            //   builder: (_, AsyncSnapshot<List<ProjectModel>> snapshot) {
            //     return snapshot.hasData
            //         ? Column(
            //             children: [
            //                TaskListWidget(snapshot: snapshot),
            //               // StatsWidget(projectList: snapshot),
            //             ],
            //           )
            //         : const SizedBox();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
