import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

Future<void> showAddProjectDialog({
  required BuildContext context,
  ProjectDialogStatus status = ProjectDialogStatus.add,
  required ProjectController projectController,
  required VoidCallback callback,
}) async {
  await showDialog(
    context: context,
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
                child: TextFormField(
                  initialValue: projectController.selectedModel.value.title,
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
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
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            projectController.setClickedValue(false);

            await projectController
                .deleteProject(
              projectModel: projectController.selectedModel.value,
              context: context,
            )
                .then((_) {
              callback();
              Navigator.pop(context);
            });

            projectController.setClickedValue(true);
          },
          child: const Text('Delete Project'),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: projectController.isClickedSubmitButton,
            builder: (__, isClicked, _) {
              return TextButton(
                onPressed: isClicked
                    ? () async {
                        projectController.setClickedValue(false);
                        await projectController.tryValidateProject(
                            context: context,
                            title: projectController.selectedModel.value.title,
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
              );
            }),
      ],
    ),
  );
}
