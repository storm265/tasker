import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';

Future<void> showAddProjectDialog({
  required BuildContext context,
  ProjectDialogStatus status = ProjectDialogStatus.add,
  required ProjectController projectController,
  required TextEditingController titleController,
  required VoidCallback callback,
}) async {
  status == ProjectDialogStatus.add
      ? projectController.titleController.clear()
      : null;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: const Text(
        'Title',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      content: SizedBox(
        height: 200,
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
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 50),
            ColorPalleteWidget(
                colorController: projectController.colorPalleteController)
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
                    onPressed: () => isClicked ? Navigator.pop(context) : null,
                    child: const Text('Back'),
                  ),
                  status == ProjectDialogStatus.add
                      ? const SizedBox()
                      : TextButton(
                          onPressed: isClicked
                              ? () async {
                                  projectController.setClickedValue(false);

                                  await projectController
                                      .deleteProject(
                                          projectModel: projectController
                                              .selectedModel.value)
                                      .then((_) {
                                    callback();
                                    Navigator.pop(context);
                                  });

                                  projectController.setClickedValue(true);
                                }
                              : null,
                          child: const Text('Delete Project'),
                        ),
                  TextButton(
                    onPressed: isClicked
                        ? () async {
                            projectController.setClickedValue(false);
                            await projectController.tryValidateProject(
                                context: context,
                                title: projectController.titleController.text,
                                isEdit: status == ProjectDialogStatus.add
                                    ? false
                                    : true,
                                onSuccessCallback: () {
                                  callback();
                                  Navigator.of(context).pop();
                                });

                            projectController.setClickedValue(true);
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
