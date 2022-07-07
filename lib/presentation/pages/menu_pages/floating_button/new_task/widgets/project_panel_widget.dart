import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';

class ProjectPanelPickerWidget extends StatelessWidget {
  const ProjectPanelPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return FutureBuilder<List<ProjectModel>>(
      initialData: const [],
      future: newTaskController.controllerProject
          .fetchProjects(title: newTaskController.inTextController.text),
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
                  isUsePositioned: false,
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
