import 'dart:developer';

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
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/utils/assets_path.dart';

class TaskListWidget extends StatefulWidget {
  final CalendarWorkMode calendarWorkMode;
  final TaskListController taskController;
  final TaskSortController taskSortController;
  const TaskListWidget({
    super.key,
    this.calendarWorkMode = CalendarWorkMode.selectedDay,
    required this.taskSortController,
    required this.taskController,
  });

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  void initState() {
    widget.taskSortController
        .generateCalendarHeader(calendarWorkMode: widget.calendarWorkMode);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.taskController.tasks,
      builder: (_, tasks, __) {
        return tasks.isEmpty
            ? Center(
                child: ProgressIndicatorWidget(text: LocaleKeys.no_data.tr()),
              )
            : ValueListenableBuilder(
                valueListenable: widget.taskController.sortStatus,
                builder: (_, sortMode, __) => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.taskSortController
                      .getDaysLength(calendarWorkMode: widget.calendarWorkMode),
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    final sortedList = widget.taskSortController.sorter(
                      tasks: tasks,
                      index: i,
                      taskSortMode: sortMode,
                    );
                    return ValueListenableBuilder(
                      valueListenable: widget.taskController.selectedDate,
                      builder: ((_, selectedDate, __) {
                        return sortedList.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    HeaderWidget(
                                      text:
                                          widget.taskSortController.headers[i],
                                    ),
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: sortedList.length,
                                        itemBuilder: (_, index) {
                                          final selectedDateList = sortedList
                                              .where((element) =>
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(
                                                          element.dueDate) ==
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate))
                                              .toList();
                                          return Slidable(
                                            key: const ValueKey(0),
                                            endActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: sortedList[index]
                                                          .ownerId ==
                                                      widget
                                                          .taskController.userId
                                                  ? [
                                                      EndPageWidget(
                                                        iconPath: AssetsPath
                                                            .editIconPath,
                                                        onClick: () async =>
                                                            Navigator.pushNamed(
                                                          context,
                                                          Pages.addTask.type,
                                                          arguments:
                                                              sortedList[index]
                                                                  .toMap(),
                                                        ),
                                                      ),
                                                      const GreySlidableWidget(),
                                                      EndPageWidget(
                                                          iconPath: AssetsPath
                                                              .deleteIconPath,
                                                          onClick: () async {
                                                            await widget.taskController.deleteTask(
                                                                taskRepository: widget
                                                                    .taskController
                                                                    .taskRepository,
                                                                taskId:
                                                                    sortedList[
                                                                            index]
                                                                        .id,
                                                                callback: () => widget
                                                                    .taskController
                                                                    .removeTaskItem(
                                                                        sortedList[index]
                                                                            .id));
                                                          }),
                                                    ]
                                                  : [],
                                            ),
                                            child: TaskCardWidget(
                                              taskController:
                                                  widget.taskController,
                                              model: selectedDateList[index],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              );
                      }),
                    );
                  },
                ),
              );
      },
    );
  }
}
