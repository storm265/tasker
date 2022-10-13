import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailted_options_dialog.dart';
import 'package:todo2/utils/assets_path.dart';

class IconPanelWidget extends StatelessWidget {
  final TaskModel selectedTask;
  final TaskListController taskListController;
  const IconPanelWidget({
    Key? key,
    required this.taskListController,
    required this.selectedTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        taskListController.userId == selectedTask.ownerId
            ? IconButton(
                onPressed: () async => await showDetailedOptions(
                  taskListController: taskListController,
                  context: context,
                  selectedTask: selectedTask,
                ),
                icon: SvgPicture.asset(AssetsPath.settingsIconPath),
              )
            : const SizedBox()
      ],
    );
  }
}
