import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/task_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/today_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/utils/assets_path.dart';

class TaskListWidget extends StatefulWidget {
  final bool isTodayMode;
  final TaskListController taskController;
  final TaskSortController taskSortController;
  const TaskListWidget({
    super.key,
    this.isTodayMode = false,
    required this.taskSortController,
    required this.taskController,
  });

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  void initState() {
    widget.taskSortController.generateHeader();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.taskController.tasks.isEmpty
        ? Center(
            child: ProgressIndicatorWidget(text: LocaleKeys.no_data.tr()),
          )
        : ValueListenableBuilder(
            valueListenable: widget.taskController.tuneIconStatus,
            builder: (_, sortMode, __) => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.taskSortController
                  .getDaysLength(isTodayMode: widget.isTodayMode),
              shrinkWrap: true,
              itemBuilder: (_, i) {
                final sortedList = widget.taskSortController.sorter(
                  tasks: widget.taskController.tasks,
                  index: i,
                  taskSortMode: sortMode,
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      HeaderWidget(text: widget.taskSortController.headers[i]),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sortedList.length,
                        itemBuilder: (_, index) => Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: sortedList[index].ownerId ==
                                    widget.taskController.userId
                                ? [
                                    EndPageWidget(
                                      iconPath: AssetsPath.editIconPath,
                                      onClick: () {
                                        // TODO implement edit function
                                      },
                                    ),
                                    const GreySlidableWidget(),
                                    EndPageWidget(
                                      iconPath: AssetsPath.deleteIconPath,
                                      onClick: () async => await widget
                                          .taskController
                                          .deleteTask(
                                        taskRepository: widget
                                            .taskController.taskRepository,
                                        taskId: sortedList[index].projectId,
                                      ),
                                    ),
                                  ]
                                : [],
                          ),
                          child: TaskCardWidget(
                            taskController: widget.taskController,
                            model: sortedList[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
