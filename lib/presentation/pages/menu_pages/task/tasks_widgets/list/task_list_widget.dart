import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/task_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/today_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/utils/assets_path.dart';

class TaskListWidget extends StatefulWidget {
  final TaskMode calendarWorkMode;
  final TaskListController taskController;
  final TaskSortController taskSortController;
  const TaskListWidget({
    super.key,
    this.calendarWorkMode = TaskMode.selectedDay,
    required this.taskSortController,
    required this.taskController,
  });

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

List<TaskModel> sortList(
  TaskMode sortMode,
  List<TaskModel> list,
) {
  final now = DateTime.now();
  final monthPattern = DateFormat('yyyy-MM');
  final todayPattern = DateFormat('yyyy-MM-dd');
  switch (sortMode) {
    case TaskMode.fullMonth:
      // TODO NOT NOW
      return list
          .where((element) =>
              monthPattern.format(element.dueDate) == monthPattern.format(now))
          .toList();
    case TaskMode.selectedDay:
      return list
          .where((element) =>
              todayPattern.format(element.dueDate) == todayPattern.format(now))
          .toList();
    case TaskMode.todayTomorrow:
      return list
          .where((element) =>
              todayPattern.format(element.dueDate) ==
                  todayPattern.format(now) &&
              monthPattern.format(element.dueDate) ==
                  monthPattern
                      .format(DateTime.utc(now.year, now.month, now.day + 1)))
          .toList();
  }
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.taskController.tasks,
      builder: (_, tasks, __) {
        // final today = tasks.where((element) =>
        //     DateFormat('yyyy-MM-dd').format(element.dueDate) ==
        //     DateFormat('yyyy-MM-dd').format(DateTime.now())).toList();

        log('tasks len ${tasks.length}');
        return tasks.isEmpty
            ? Center(
                child: ProgressIndicatorWidget(text: LocaleKeys.no_data.tr()),
              )
            : ValueListenableBuilder(
                // incomplete,
                // completed,
                // all,
                valueListenable: widget.taskController.sortMode,

                builder: ((_, sortMode, __) {
                  // final sortedList = sortList(sortMode, tasks);
                  return ValueListenableBuilder(
                    // todayTomorrow
                    // selectedDay
                    // fullMonth
                    valueListenable:
                        widget.taskController.calendarProvider.taskMode,
                    builder: (__, calendarMode, _) {
                      return GroupedListView<TaskModel, DateTime>(
                        elements: tasks,
                        groupBy: (TaskModel element) => DateTime(
                          element.dueDate.year,
                          element.dueDate.month,
                          element.dueDate.day,
                        ),

                        order: GroupedListOrder.ASC, // lower - higher
                        useStickyGroupSeparators:
                            true, // optional (keeps header at top)
                        floatingHeader:
                            true, // optional (hides background of header)
                        groupSeparatorBuilder: (DateTime value) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HeaderWidget(
                            text:
                                '${DateFormat('MMM').format(value)} ${value.day}/${value.year}',
                          ),
                        ),
                        itemBuilder: (_, element) {
                          return Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: element.ownerId ==
                                      widget.taskController.userId
                                  ? [
                                      EndPageWidget(
                                        iconPath: AssetsPath.editIconPath,
                                        onClick: () async =>
                                            Navigator.pushNamed(
                                          context,
                                          Pages.addTask.type,
                                          arguments: element.toMap(),
                                        ),
                                      ),
                                      const GreySlidableWidget(),
                                      EndPageWidget(
                                          iconPath: AssetsPath.deleteIconPath,
                                          onClick: () async {
                                            await widget.taskController
                                                .deleteTask(
                                              taskRepository: widget
                                                  .taskController
                                                  .taskRepository,
                                              taskId: element.id,
                                              callback: () => widget
                                                  .taskController
                                                  .removeTaskItem(element.id),
                                            );
                                          }),
                                    ]
                                  : [],
                            ),
                            child: TaskCardWidget(
                              taskController: widget.taskController,
                              model: element,
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              );
      },
    );
  }
}
