import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/presentation/providers/user_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_padding_constants.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
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
  final userController = UserProvider(
    userProfileRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        network: NetworkSource(),
        secureStorageService: SecureStorageSource(),
      ),
    ),
  );
  final profileController = ProfileController(
    taskRepository: TaskRepositoryImpl(),
    notesRepository: NoteRepositoryImpl(
      noteDataSource: NotesDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageSource(),
      ),
    ),
    fileProvider: FileProvider(),
    secureStorageService: SecureStorageSource(),
    userProfileRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        network: NetworkSource(),
        secureStorageService: SecureStorageSource(),
      ),
    ),
    authRepository: AuthRepositoryImpl(),
  );

  @override
  void initState() {
    Future.wait([
      userController.fetchStats(),
      profileController.fetchCardsData(),
    ]).then((_) => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      title: LocaleKeys.profile.tr(),
      isRedAppBar: false,
      child: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: vertical,
              ),
              child: ProfileWidget(
                profileController: profileController,
                fileProvider: profileController.fileProvider,
                completedTasks: userController.stats.completedTasks,
                createdTask: userController.stats.createdTasks,
              ),
            ),
            Column(
              children: [
                TaskListWidget(
                  model: userController.stats,
                  cardLength: profileController.cardLength,
                ),
                StatsWidget(statsModel: userController.stats),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
