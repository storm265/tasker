import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/add_project_dialog.dart';

class AddProjectButton extends StatelessWidget {
  final Function notifyParent;
  final ProjectController projectController;
  const AddProjectButton({
    Key? key,
    required this.notifyParent,
    required this.projectController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () async => await showAddProjectDialog(
          context: context,
          projectController: projectController,
        ).then((_) => notifyParent()),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors[0],
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
