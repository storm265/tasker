import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/panels/project_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/panels/user_panel_widget.dart';

class SelectPanelWidget extends StatelessWidget {
  SelectPanelWidget({Key? key}) : super(key: key);
  final taskController = AddTaskController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFF4F4F4),
      ),
      height: 500,
      width: 365,
      child: ValueListenableBuilder<InputFieldStatus>(
        valueListenable: taskController.panelStatus,
        builder: (context, status, _) {
          switch (status) {
            case InputFieldStatus.hide:
              return const SizedBox();
            case InputFieldStatus.showUserPanel:
              // TODO not updating if const
              return UserPanelPickerWidget();
            case InputFieldStatus.showProjectPanel:
              // TODO not updating if const
              return ProjectPanelPickerWidget();
          }
        },
      ),
    );
  }
}
