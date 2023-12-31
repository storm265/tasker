import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/model/project_models/project_stats_model.dart';
import 'package:todo2/domain/model/project_models/projects_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/menu_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_item_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/activity_indicator_widget.dart';
import 'package:todo2/services/dependency_service/dependency_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final _projectController = getIt<ProjectController>();

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
                    child: ActivityIndicatorWidget(
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
                    itemBuilder: (_, i) =>
                        ValueListenableBuilder<List<ProjectStatsModel>>(
                      valueListenable: _projectController.projectStats,
                      builder: (_, tasksNumber, __) => ProjectItemWidget(
                        projectController: _projectController,
                        selectedModel: projectsList[i],
                        taskLength: tasksNumber.isEmpty
                            ? 0
                            : tasksNumber[i].tasksNumber,
                      ),
                    ),
                  )),
          ),
        ),
      ),
    );
  }
}
