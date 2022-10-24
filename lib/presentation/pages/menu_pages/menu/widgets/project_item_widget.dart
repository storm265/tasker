import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/menu_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/add_project_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/category_length_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/category_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

String detailedId = '';
String projectTitle='';

class ProjectItemWidget extends StatelessWidget {
  final ProjectModel selectedModel;
  final int taskLength;
  final ProjectController projectController;

  const ProjectItemWidget({
    Key? key,
    required this.selectedModel,
    required this.taskLength,
    required this.projectController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () async {
        await navigationController.moveToPage(Pages.detailedProject);
        detailedId = selectedModel.id;
        projectTitle = selectedModel.title;
      },
      onLongPress: selectedModel.title == 'Personal'
          ? null
          : () async {
              projectController.findEditColor(model: selectedModel);
              await showAddEditProjectDialog(
                context: context,
                projectController: projectController,
                status: ProjectDialogStatus.edit,
              );
            },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 0.6,
                blurRadius: 4,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: DoubleCircleWidget(
                    color: selectedModel.color,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryWidget(title: selectedModel.title),
                      const SizedBox(height: 9),
                      CategoryLengthWidget(taskLength: taskLength)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
