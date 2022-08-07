import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/options_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_shimmer_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final titleController = TextEditingController();
  final _projectController = ProjectController(
    ProjectRepositoryImpl(),
    ColorPalleteController(),
  );
  @override
  void dispose() {
    _projectController.disposeValues();
    _projectController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  FutureBuilder<BaseListResponse<ProjectModel>>(
                    initialData: BaseListResponse<ProjectModel>(model: []),
                    future: _projectController.fetchAllProjects(),
                    builder: (_,
                        AsyncSnapshot<BaseListResponse<ProjectModel>>
                            snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.model.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemBuilder: (BuildContext context, index) {
                              final data = snapshot.data!.model[index];
                              return snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? ShimmerProjectItem(model: data)
                                  : Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: InkWell(
                                        onLongPress: snapshot
                                                    .data!.model[index].title ==
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
                                        child: ProjectItemWidget(model: data),
                                      ),
                                    );
                            });
                      }
                      if (snapshot.data!.model.isEmpty) {
                        return const Text('No projects');
                      } else {
                        return const ProgressIndicatorWidget();
                      }
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
