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

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.taskController.tasks,
      builder: (_, tasks, __) {
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
                  final sortedList =
                      widget.taskSortController.taskModeSort(tasks: tasks);

                  return ValueListenableBuilder(
                    valueListenable:
                        widget.taskController.calendarProvider.selectedMonth,
                    builder: (_, selectedMonth, __) {
                      log('selectedMonth $selectedMonth');
                      return ValueListenableBuilder(
                        // todayTomorrow
                        // selectedDay
                        // fullMonth
                        valueListenable:
                            widget.taskController.calendarProvider.calendarMode,
                        builder: (__, calendarMode, _) {
                          final ss = widget.taskSortController.sortList(
                            calendarMode,
                            sortedList,
                            selectedMonth,
                          );
                          log('ss len ${ss.length}');
                          return SizedBox(
                            width: double.infinity,
                            height: 350, //TODO fix it
                            child: GroupedListView<TaskModel, DateTime>(
                              elements: ss,
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
                              groupSeparatorBuilder: (DateTime value) =>
                                  Padding(
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
                                                iconPath:
                                                    AssetsPath.deleteIconPath,
                                                onClick: () async {
                                                  await widget.taskController
                                                      .deleteTask(
                                                    taskRepository: widget
                                                        .taskController
                                                        .taskRepository,
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
