import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/add_project_dialog_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

Future<void> showAddProjectDialog(BuildContext context) async {
  final addProjectController = AddProjectDialogController();
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
                    key: addProjectController.formKey,
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
                      controller: addProjectController.titleController,
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
                    colorController:
                        addProjectController.colorPalleteController)
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        ValueListenableBuilder<bool>(
          valueListenable: addProjectController.isClickedButton,
          builder: (__, isClicked, _) => TextButton(
            onPressed: () async {
              isClicked
                  ? await addProjectController
                      .validate()
                      .then((_) => Navigator.of(context).pop())
                  : null;
            },
            child: const Text('Add Project'),
          ),
        ),
      ],
    ),
  );
}
