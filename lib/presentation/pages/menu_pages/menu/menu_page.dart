import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_shimmer_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  late TextEditingController _titleController;
  late ProjectController _projectController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _projectController = ProjectController(
      ProjectRepositoryImpl(
        projectDataSource: ProjectUserDataImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
      ColorPalleteController(),
    );
    _projectController.fetchAllProjects();
    super.initState();
  }

  @override
  void dispose() {
    log('disposed menu');
    _projectController.disposeValues();
    _projectController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AddProjectButton(
        titleController: _titleController,
        projectController: _projectController,
        callback: () => Navigator.pop(context),
      ),
      isWhite: false,
      title: 'Projects',
      isRedAppBar: false,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ValueListenableBuilder<List<ProjectModel>>(
            valueListenable: _projectController.projects,
            builder: ((__, projectsList, _) => (projectsList.isEmpty)
                ? const Center(child: Text('No projects'))
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
                          : ProjectItemWidget(
                              projectController: _projectController,
                              model: projectsList[i],
                              // taskLength: snapshot
                              //     .data![i].tasksNumber,
                              taskLength: 0,
                              callback: () => Navigator.pop(context),
                            );
                    })),
          ),
        ),
      ),
    );
  }
}
