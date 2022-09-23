import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/detailed_task.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/task_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/today_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/utils/assets_path.dart';
final now = DateTime.now();
class ListWidget extends StatelessWidget {
  final List<TaskModel> modelList;
  final bool isToday;
  const ListWidget({
    Key? key,
    required this.modelList,
    required this.isToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todayList = modelList
        .where((element) =>
            DateFormat('yyyy-MM-dd').format(element.dueDate) ==
            DateFormat('yyyy-MM-dd').format(DateTime.utc(now.year, now.month, now.day)))
        .toList();
    todayList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    final tomorrowList = modelList
        .where((element) =>
            DateFormat('yyyy-MM-dd').format(element.dueDate) ==
            DateFormat('yyyy-MM-dd').format(DateTime.utc(now.year, now.month, now.day+1)))
        .toList();
    tomorrowList.sort((a, b) => a.dueDate.compareTo(b.dueDate));

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
                        onClick: () {},
                      ),
                      const GreySlidableWidget(),
                      EndPageWidget(
                        iconPath: AssetsPath.deleteIconPath,
                        onClick: () {},
                      ),
                    ],
                  ),
                  child: TaskCardWidget(
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
