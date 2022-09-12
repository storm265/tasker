import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/add_project_dialog.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class AddButton extends StatelessWidget {
  final ProjectController projectController;
  final TextEditingController titleController;
  final VoidCallback callback;
  const AddButton({
    Key? key,
    required this.titleController,
    required this.projectController,
    required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getAppColor(color: CategoryColor.blue),
      onPressed: () async => await showAddEditProjectDialog(
        titleController: titleController,
        context: context,
        projectController: projectController,
        callback: () => callback(),
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
