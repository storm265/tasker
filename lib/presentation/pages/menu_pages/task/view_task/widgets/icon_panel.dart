import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/domain/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailed/detailted_options_dialog.dart';
import 'package:todo2/utils/assets_path.dart';

class IconPanelWidget extends StatelessWidget {
  final TaskModel selectedTask;
  final TaskList taskListController;
  final ViewTaskController viewTaskController;
  const IconPanelWidget({
    Key? key,
    required this.taskListController,
    required this.viewTaskController,
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
                  viewTaskController: viewTaskController,
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
