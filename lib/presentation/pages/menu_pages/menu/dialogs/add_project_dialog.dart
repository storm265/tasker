import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

Future<void> showAddProjectDialog({
  required BuildContext context,
  ProjectDialogStatus status = ProjectDialogStatus.add,
  required ProjectController projectController,
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
            height: 230,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Form(
                    key: projectController.formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter title';
                        }
                        if (value.length < 2) {
                          return 'Title must be at least 2 characters';
                        }
                        return null;
                      },
                      controller: projectController.titleController,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(right: 220, bottom: 20),
                  child: Text(
                    'Title',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                ColorPalleteWidget(
                  colorController: projectController.colorPalleteController,
                )
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        ValueListenableBuilder<bool>(
            valueListenable: projectController.isClickedSubmitButton,
            builder: (__, isClicked, _) {
              switch (status) {
                case ProjectDialogStatus.add:
                  return TextButton(
                    onPressed: () async {
                      isClicked
                          ? await projectController
                              .validate(
                              context: context,
                              isEdit: status == ProjectDialogStatus.add
                                  ? false
                                  : true,
                            )
                              .then((_) {
                              Navigator.of(context).pop();
                              projectController.titleController.dispose();
                              // projectController.disposeValues();
                            })
                          : null;
                    },
                    child: const Text('Add Project'),
                  );

                case ProjectDialogStatus.edit:
                  return TextButton(
                    onPressed: () async {
                      isClicked
                          ? await projectController
                              .postProject(
                                  projectModel:
                                      projectController.selectedModel.value)
                              .then((_) => Navigator.of(context).pop())
                          : null;
                    },
                    child: const Text('Edit Project'),
                  );
                case ProjectDialogStatus.remove:
                  break;
                default:
                  break;
              }
              return const SizedBox();
            }),
      ],
    ),
  );
}
