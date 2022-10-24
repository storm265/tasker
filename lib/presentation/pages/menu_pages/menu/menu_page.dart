import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_provider/color_pallete_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/menu_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_shimmer_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final _projectController = ProjectController(
    colorPalleteController: ColorPalleteProvider(),
    projectsRepository: ProjectRepositoryImpl(
      projectDataSource: ProjectUserDataImpl(
        secureStorageService: SecureStorageSource(),
        network: NetworkSource(),
      ),
    ),
  );

  @override
  void initState() {
    _projectController.fetchProjectStats();
    _projectController.fetchAllProjects();
    super.initState();
  }

  @override
  void dispose() {
    _projectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AddProjectButton(
        projectController: _projectController,
      ),
      isWhite: false,
      title: LocaleKeys.projects.tr(),
      isRedAppBar: false,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ValueListenableBuilder<List<ProjectModel>>(
            valueListenable: _projectController.projects,
            builder: ((__, projectsList, _) => (projectsList.isEmpty)
                ? Center(
                    child: ProgressIndicatorWidget(
                      text: LocaleKeys.no_data.tr(),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: projectsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemBuilder: (_, i) {
                      return projectsList.isEmpty
                          ? ShimmerProjectItem()
                          : ValueListenableBuilder<List<ProjectStatsModel>>(
                              valueListenable: _projectController.projectStats,
                              builder: (_, tasksNumber, __) =>
                                  ProjectItemWidget(
                                projectController: _projectController,
                                selectedModel: projectsList[i],
                                taskLength: tasksNumber.isEmpty
                                    ? 0
                                    : tasksNumber[i].tasksNumber,
                              ),
                            );
                    },
                  )),
          ),
        ),
      ),
    );
  }
}
