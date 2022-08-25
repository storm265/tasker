import 'package:flutter/material.dart';

import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task/widgets/project_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task/widgets/user_panel_widget.dart';

class SelectPanelWidget extends StatelessWidget {
  const SelectPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
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
              // TODO not updating if const
              return  UserPanelPickerWidget();
            case InputFieldStatus.showProjectPanel:
            // TODO not updating if const
              return ProjectPanelPickerWidget();
          }
        },
      ),
    );
  }
}
