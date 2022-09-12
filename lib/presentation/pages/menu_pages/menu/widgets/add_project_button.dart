import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/add_project_dialog.dart';

class AddProjectButton extends StatelessWidget {
  final ProjectController projectController;
  final TextEditingController titleController;
  final VoidCallback callback;
  const AddProjectButton({
    Key? key,
    required this.titleController,
    required this.projectController,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await showAddEditProjectDialog(
        titleController: titleController,
        context: context,
        projectController: projectController,
        callback: ()=> callback(),
      ),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getAppColor(color: CategoryColor.blue),
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
      ),
    );
  }
}
