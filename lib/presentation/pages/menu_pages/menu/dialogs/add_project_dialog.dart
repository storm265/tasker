import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';

Future<void> showAddEditProjectDialog({
  required BuildContext context,
  ProjectDialogStatus status = ProjectDialogStatus.add,
  required ProjectController projectController,
}) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          'Title',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ),
        ),
      ),
      content: SizedBox(
        height: 230,
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: Form(
                key: projectController.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  controller: projectController.titleController,
                  buildCounter: (
                    context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) =>
                      maxLength == currentLength
                          ? const Text(
                              '32/32',
                              style: TextStyle(color: Colors.red),
                            )
                          : null,
                  maxLength: 32,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter title';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            ColorPalleteWidget(
              colorController: projectController.colorPalleteController,
            )
          ],
        ),
      ),
      actions: <Widget>[
        ValueListenableBuilder<bool>(
            valueListenable: projectController.isClickedSubmitButton,
            builder: (__, isClicked, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: isClicked
                        ? () {
                            projectController.clearProjects();
                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text('Back'),
                  ),
                  status == ProjectDialogStatus.add
                      ? const SizedBox()
                      : TextButton(
                          onPressed: isClicked
                              ? () async {
                                  await projectController
                                      .deleteProject()
                                      .then((_) => Navigator.pop(context));
                                }
                              : null,
                          child: const Text('Delete Project'),
                        ),
                  TextButton(
                    onPressed: isClicked
                        ? () async {
                            await projectController
                                .tryValidateProject(
                                  isEdit: status == ProjectDialogStatus.add
                                      ? false
                                      : true,
                                )
                                .then((_) => Navigator.pop(context));
                          }
                        : null,
                    child: Text(
                      status == ProjectDialogStatus.add
                          ? 'Add Project'
                          : 'Update Project',
                    ),
                  ),
                ],
              );
            }),
      ],
    ),
  );
}
