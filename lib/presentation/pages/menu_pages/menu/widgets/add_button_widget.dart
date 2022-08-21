import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/add_project_dialog.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class AddButton extends StatelessWidget {
  final Function notifyParent;
  final ProjectController projectController;
  final TextEditingController titleController;
  const AddButton({
    Key? key,
    required this.titleController,
    required this.notifyParent,
    required this.projectController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getAppColor(color: CategoryColor.blue),
      onPressed: () async => await showAddProjectDialog(
        titleController: titleController,
        context: context,
        projectController: projectController,
        callback: () => notifyParent(),
      ),
      child: const Center(
        child: Text(
          '+',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
