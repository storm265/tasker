import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/task_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/today_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/utils/assets_path.dart';

class TaskListWidget extends StatefulWidget {
  final TaskMode calendarWorkMode;
  final TaskList taskController;
  final TaskSortProvider taskSortController;
  const TaskListWidget({
    super.key,
    this.calendarWorkMode = TaskMode.selectedDay,
    required this.taskSortController,
    required this.taskController,
  });

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  void initState() {
    widget.taskController.calendarProvider
        .updateTaskWorkMode(widget.calendarWorkMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.taskController.tasks,
      builder: (_, tasks, __) {
        log('tasks len ${tasks.length}');

        return ValueListenableBuilder(
          // incomplete,
          // completed,
          // all,
          valueListenable: widget.taskController.sortMode,

          builder: ((_, sortMode, __) {
            final sortedModeList =
                widget.taskSortController.taskModeSort(tasks: tasks);

            return ValueListenableBuilder(
              valueListenable:
                  widget.taskController.calendarProvider.selectedMonth,
              builder: (_, selectedMonth, __) {
                return ValueListenableBuilder(
                  // todayTomorrow
                  // selectedDay
                  // fullMonth
                  valueListenable:
                      widget.taskController.calendarProvider.calendarMode,
                  builder: (__, calendarMode, _) {
                    final calendarModeSortedList =
                        widget.taskSortController.sortList(
                      calendarMode,
                      sortedModeList,
                      selectedMonth,
                    );
                    return calendarModeSortedList.isEmpty
                        ? Center(
                            child: Text(
                              LocaleKeys.no_tasks.tr(),
                            ),
                          )
                        : GroupedListView<TaskModel, DateTime>(
                            elements: calendarModeSortedList,
                            groupBy: (TaskModel element) => DateTime(
                              element.dueDate.year,
                              element.dueDate.month,
                              element.dueDate.day,
                            ),
                            reverse: true,
                            shrinkWrap: true,
                            order: GroupedListOrder.ASC,
                            useStickyGroupSeparators: false,
                            floatingHeader: false,
                            groupSeparatorBuilder: (DateTime value) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: HeaderWidget(
                                text:
                                    '${widget.taskSortController.formatDay(value)} ${DateFormat('MMM').format(value)} ${value.day}/${value.year}',
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
                                          DateTime.now()
                                                  .isBefore(element.dueDate)
                                              ? EndPageWidget(
                                                  iconPath:
                                                      AssetsPath.editIconPath,
                                                  onClick: () async =>
                                                      Navigator.pushNamed(
                                                    context,
                                                    Pages.addTask.type,
                                                    arguments: element.toMap(),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          const GreySlidableWidget(),
                                          EndPageWidget(
                                              iconPath:
                                                  AssetsPath.deleteIconPath,
                                              onClick: () async {
                                                await widget.taskController
                                                    .deleteTask(
                                                  taskId: element.id,
                                                  callback: () => widget
                                                      .taskController
                                                      .removeTaskItem(
                                                          element.id),
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
              },
            );
          }),
        );
      },
    );
  }
}
