import 'package:flutter/material.dart';
import 'package:todo2/controller/add_tasks/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

Future<void> showMaterialDialog(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final colorPalleteController = ColorPalleteController();
  int selectedIndex = 0;
  bool isClickedButton = true;
  final titleController = TextEditingController();
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
                    key: formKey,
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
                      controller: titleController,
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
                  colorController: colorPalleteController,
                )
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        StatefulBuilder(
          builder: ((context, setState) => TextButton(
                onPressed: isClickedButton
                    ? () async {
                        if (formKey.currentState!.validate()) {
                          setState(() => isClickedButton = false);
                          (titleController.text.length >= 2)
                              ? await ProjectRepositoryImpl()
                                  .putData(
                                      color: colors[selectedIndex]
                                          .value
                                          .toString(),
                                      title: titleController.text)
                                  .then((_) => Navigator.of(context).pop())
                              : null;
                          setState(() => isClickedButton = true);
                        }
                      }
                    : null,
                child: const Text('Add Project'),
              )),
        )
      ],
    ),
  );
}
