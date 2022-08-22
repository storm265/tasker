import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/add_project_dialog.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class AddProjectButton extends StatelessWidget {
  final Function notifyParent;
  final ProjectController projectController;
  final TextEditingController titleController;
  const AddProjectButton({
    Key? key,
    required this.titleController,
    required this.notifyParent,
    required this.projectController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () async => await showAddProjectDialog(
      //   titleController: titleController,
      //   context: context,
      //   projectController: projectController,
      //   callback: () => notifyParent(),
      // ),
      onTap: () => ProjectUserDataImpl(
              secureStorageService: SecureStorageService(),
              network: NetworkSource())
          .fetchProjectsWhere(title: 'Personal'),
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
