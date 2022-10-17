import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/panels/project_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/panels/user_panel_widget.dart';

class SelectPanelWidget extends StatelessWidget {
  final AddEditTaskController addEditTaskController;
  const SelectPanelWidget({
    Key? key,
    required this.addEditTaskController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFF4F4F4),
      ),
      height: 500,
      width: 365,
      child: ValueListenableBuilder<PanelStatus>(
        valueListenable: addEditTaskController.panelProvider.panelStatus,
        builder: (context, status, _) {
          switch (status) {
            case PanelStatus.hide:
              return const SizedBox();
            case PanelStatus.showUserPanel:
              return UserPanelPickerWidget(
                addEditTaskController: addEditTaskController,
              );
            case PanelStatus.showProjectPanel:
              return ProjectPanelPickerWidget(
                addEditTaskController: addEditTaskController,
              );
          }
        },
      ),
    );
  }
}
