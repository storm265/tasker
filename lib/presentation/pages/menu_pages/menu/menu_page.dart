import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/options_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_shimmer_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/inherited_profile.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late TextEditingController titleController;
  late ProjectController _projectController;

  @override
  void initState() {
    titleController = TextEditingController();
    _projectController = ProjectController(
      ProjectRepositoryImpl(),
      ColorPalleteController(),
    );
    log('init MenuPage page');
    super.initState();
  }

  @override
  void dispose() {
    _projectController.disposeValues();
    _projectController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileInherited.of(context).profileController;
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        title: 'Projects',
        isRedAppBar: false,
        child: DisabledGlowWidget(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  FutureBuilder<List<ProjectModel>>(
                    future: _projectController.fetchAllProjects(),
                    builder: (_, AsyncSnapshot<List<ProjectModel>> snapshot) {
                      return (!snapshot.hasData)
                          ? const Text('No projects')
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                              ),
                              itemBuilder: (_, i) {
                                final data = snapshot.data![i];
                                return snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? ShimmerProjectItem(model: data)
                                    : InkWell(
                                        onLongPress: snapshot.data![i].title ==
                                                'Personal'
                                            ? null
                                            : () {
                                                _projectController.pickProject(
                                                    pickedModel: data);
                                                showOptionsDialog(
                                                  titleController:
                                                      titleController,
                                                  notifyParent: () =>
                                                      setState(() {}),
                                                  projectController:
                                                      _projectController,
                                                  context: context,
                                                  projectModel: data,
                                                );
                                              },
                                        child: FutureBuilder(
                                            initialData: const <
                                                ProjectStatsModel>[],
                                            future: profileController
                                                .fetchProjectStats(),
                                            builder: (context,
                                                AsyncSnapshot<
                                                        List<ProjectStatsModel>>
                                                    snapshot) {
                                              return snapshot.connectionState ==
                                                      ConnectionState.waiting
                                                  ? const SizedBox()
                                                  : ProjectItemWidget(
                                                      model: data,
                                                      taskLength: snapshot
                                                          .data![i]
                                                          .tasksNumber);
                                            }),
                                      );
                              });
                    },
                  ),
                  AddProjectButton(
                    titleController: titleController,
                    projectController: _projectController,
                    notifyParent: () => setState(() {}),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
