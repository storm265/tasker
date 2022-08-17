import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

Future<void> showAddProjectDialog({
  required BuildContext context,
  ProjectDialogStatus status = ProjectDialogStatus.add,
  required ProjectController projectController,
  required TextEditingController titleController,
}) async {
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: const Text(
        'Title',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      content: DisabledGlowWidget(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Form(
                    key: projectController.formKey,
                    child: TextFormField(
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
        ),
      ),
      actions: <Widget>[
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
                          isEdit:
                              status == ProjectDialogStatus.add ? false : true,
                          onSuccessCallback: () => Navigator.of(context).pop(),
                        );

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
