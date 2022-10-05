import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/task_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/today_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/utils/assets_path.dart';

class ListWidget extends StatelessWidget {
  final List<TaskModel> modelList;
  final bool isToday;
  final AddTaskController taskController;
  const ListWidget({
    Key? key,
    required this.modelList,
    required this.isToday,
    required this.taskController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final todayList = modelList
        .where(
          (element) =>
              DateFormat('yyyy-MM-dd').format(element.dueDate) ==
              DateFormat('yyyy-MM-dd').format(
                DateTime.utc(timeNow.year, timeNow.month, timeNow.day),
              ),
        )
        .toList();
    todayList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    final tomorrowList = modelList
        .where(
          (element) =>
              DateFormat('yyyy-MM-dd').format(element.dueDate) ==
              DateFormat('yyyy-MM-dd').format(
                DateTime.utc(timeNow.year, timeNow.month, timeNow.day + 1),
              ),
        )
        .toList();
    tomorrowList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    log('today len ${todayList.length}');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListDayWidget(isToday: isToday),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: isToday ? todayList.length : tomorrowList.length,
              itemBuilder: (_, i) {
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      EndPageWidget(
                        iconPath: AssetsPath.editIconPath,
                        onClick: () {
                          // TODO implement edit function
                        },
                      ),
                      const GreySlidableWidget(),
                      EndPageWidget(
                        iconPath: AssetsPath.deleteIconPath,
                        onClick: () async => await taskController.deleteTask(
                            taskId: modelList[i].projectId),
                      ),
                    ],
                  ),
                  child: TaskCardWidget(
                    taskController: taskController,
                    data: isToday ? modelList : tomorrowList,
                    index: i,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
