import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';

class ProjectPanelPickerWidget extends StatelessWidget {
  const ProjectPanelPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return FutureBuilder<List<ProjectModel>>(
      initialData: const [],
      future: newTaskController.projectController
          .searchProject(title: newTaskController.projectTextController.text),
      builder: (context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final data = snapshot.data![index];
            return InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                newTaskController.changePanelStatus(
                    newStatus: InputFieldStatus.hide);
              },
              child: ListTile(
                onTap: () => newTaskController.pickProject(
                  newProject: data,
                  context: context,
                ),
                leading: DoubleCircleWidget(
                  color: data.color,
                ),
                title: Text(data.title),
              ),
            );
          },
        );
      },
    );
  }
}
