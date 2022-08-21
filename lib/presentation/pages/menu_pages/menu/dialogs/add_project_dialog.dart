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
                child: TextFormField(
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
                  controller: titleController,
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
        ValueListenableBuilder<bool>(
            valueListenable: projectController.isClickedSubmitButton,
            builder: (__, isClicked, _) {
              return TextButton(
                onPressed: isClicked
                    ? () async {
                        projectController.setClickedValue(false);
                        await projectController.validate(
                            context: context,
                            title: titleController.text,
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
