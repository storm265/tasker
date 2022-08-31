import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/inherited_profile.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_padding_constants.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/stats_widget/stats_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/task_list_widgets/task_list_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/profile_widget.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final imageController = ImageController(
    userRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        network: NetworkSource(),
        secureStorageService: SecureStorageService(),
      ),
    ),
  );
  final userController = UserController(
    userProfileRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        network: NetworkSource(),
        secureStorageService: SecureStorageService(),
      ),
    ),
  );

  @override
  void initState() {
    userController.fetchStats();
    super.initState();
  }

  @override
  void dispose() {
    // TODO DANGER DISPOSE
    imageController.pickedFile.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inheritedProfile = ProfileInherited.of(context);
    return AppbarWrapWidget(
      title: 'Profile',
      isRedAppBar: false,
      child: Flex(
        // spacing: 10,
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: vertical,
            ),
            child: ProfileWidget(
              profileController: inheritedProfile.profileController,
              imageController: imageController,
              //   completedTasks: stats.completedTasks,
              //   createdTask: stats.createdTasks,
              completedTasks: 999,
              createdTask: 999,
            ),
          ),
          Column(
            children: [
              TaskListWidget(model: userController.stats),
              StatsWidget(statsModel: userController.stats),
            ],
          )
        ],
      ),
    );
  }
}
