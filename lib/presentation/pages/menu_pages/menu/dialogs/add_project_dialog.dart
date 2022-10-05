import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
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
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          LocaleKeys.title.tr(),
          style: const TextStyle(
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
                      return LocaleKeys.please_enter_title.tr();
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
            valueListenable: projectController.isActiveSubmitButton,
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
                    child: Text(
                      LocaleKeys.back.tr(),
                    ),
                  ),
                  status == ProjectDialogStatus.add
                      ? const SizedBox()
                      : TextButton(
                          onPressed: isClicked
                              ? () async {
                                  await projectController.deleteProject(
                                      context: context);
                                }
                              : null,
                          child: Text(
                            LocaleKeys.delete_project.tr(),
                          ),
                        ),
                  TextButton(
                    onPressed: isClicked
                        ? () async {
                            await projectController.tryValidateProject(
                              context: context,
                              isEdit: status == ProjectDialogStatus.add
                                  ? false
                                  : true,
                            );
                          }
                        : null,
                    child: Text(
                      status == ProjectDialogStatus.add
                          ? LocaleKeys.add_project.tr()
                          : LocaleKeys.update_project.tr(),
                    ),
                  ),
                ],
              );
            }),
      ],
    ),
  );
}
