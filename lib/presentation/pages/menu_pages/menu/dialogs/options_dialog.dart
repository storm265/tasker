import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/add_project_dialog.dart';

Future<void> showOptionsDialog({
  required Function notifyParent,
  required BuildContext context,
  required ProjectModel projectModel,
  required ProjectController projectController,
  required TextEditingController titleController,
}) async {
  final icons = [Icons.edit, Icons.delete];
  final titles = ['Edit', 'Remove'];
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: 70,
        height: 100,
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: ((context, index) => GestureDetector(
                onTap: () async {
                  switch (index) {
                    case 0:
                      Navigator.pop(context);
                      await showAddProjectDialog(
                        titleController: titleController,
                        context: context,
                        projectController: projectController,
                        status: ProjectDialogStatus.edit,
                      );
                      break;
                    case 1:
                      await projectController
                          .deleteProject(projectModel: projectModel)
                          .then((_) {
                        Navigator.pop(context);
                        notifyParent();
                      });
                      break;
                  }
                },
                child: ListTile(
                  leading: Icon(
                    icons[index],
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(titles[index]),
                ),
              )),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
