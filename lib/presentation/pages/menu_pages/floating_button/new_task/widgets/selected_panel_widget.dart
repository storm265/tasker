
import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/project_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/user_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';
import 'package:todo2/services/supabase/constants.dart';

class SelectUserWidget extends StatelessWidget {
  UserProfileModel? selectedModel;
  ProjectModel? selectedProject;
  // Inject dependency

  List emailResponce = [];
  
  // TODO fix in future
// Future<void> ddd ({required String userName})async{
//   controllerUserProfile.fetchUsers(userName: userName);
//          emailResponce = await UserRepositoryImpl().fetchEmail();

// }
  SelectUserWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   final newTaskController  = InheritedNewTaskController.of(context).addTaskController;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFF4F4F4),
        ),
        height: 500,
        width: 365,
        child: ValueListenableBuilder<InputFieldStatus>(
          valueListenable: newTaskController.panelStatus,
          builder: (context, status, _) {
            switch (status) {
              case InputFieldStatus.hide:
                return const SizedBox();
              case InputFieldStatus.showUserPanel:
                return UserPanelPickerWidget();
              case InputFieldStatus.showProjectPanel:
                return ProjectPanelPickerWidget();
            }
          },
        ));
  }
}