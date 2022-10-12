import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';

class TaskSortController {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  List<TaskModel> sortedList = [];
  List<String> headers = [];

  void generateHeader({bool isTodayMode = false}) {
    for (var i = 0; i < getDaysLength(isTodayMode: isTodayMode); i++) {
      if (i == 0) {
        headers.add(
            '${LocaleKeys.today.tr()} ${DateFormat('MMM').format(now)} ${now.day}/${now.year}');
      }
      if (i == 1) {
        headers.add(
            '${LocaleKeys.tomorrow.tr()}  ${DateFormat('MMM').format(now)} ${now.day + 1}/${now.year}');
      }
      if (i > 1) {
        headers
            .add('${DateFormat('MMM').format(now)} ${now.day + i}/${now.year}');
      }
    }
  }

  int getDaysLength({bool isTodayMode = false}) {
    if (isTodayMode) {
      return 2;
    } else {
      final now = DateTime.now();
      DateTime x1 = now.toUtc();
      return DateTime(now.year, now.month + 1, 0)
              .toUtc()
              .difference(x1)
              .inDays +
          2;
    }
  }

  List<TaskModel> sorter({
    required List<TaskModel> tasks,
    required int index,
    TaskSortMode taskSortMode = TaskSortMode.all,
  }) {
    switch (taskSortMode) {
      case TaskSortMode.all:
        if (index == 0) {
          sortedList = tasks
              .where(
                (element) =>
                    formatter.format(element.dueDate) ==
                    formatter.format(
                      DateTime.utc(now.year, now.month, now.day),
                    ),
              )
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        }
        if (index == 1) {
          sortedList = tasks
              .where(
                (element) =>
                    formatter.format(element.dueDate) ==
                    formatter.format(
                      DateTime.utc(now.year, now.month, now.day + 1),
                    ),
              )
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        } else {
          sortedList = tasks
              .where(
                (element) =>
                    formatter.format(element.dueDate) ==
                    formatter.format(
                      DateTime.utc(now.year, now.month, now.day + index),
                    ),
              )
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        }
        break;

      case TaskSortMode.completed:
        if (index == 0) {
          sortedList = tasks
              .where((element) =>
                  formatter.format(element.dueDate) ==
                      formatter.format(
                        DateTime.utc(now.year, now.month, now.day),
                      ) &&
                  element.isCompleted == true)
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        }
        if (index == 1) {
          sortedList = tasks
              .where((element) =>
                  formatter.format(element.dueDate) ==
                      formatter.format(
                        DateTime.utc(now.year, now.month, now.day + 1),
                      ) &&
                  element.isCompleted == true)
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        } else {
          sortedList = tasks
              .where((element) =>
                  formatter.format(element.dueDate) ==
                      formatter.format(
                        DateTime.utc(now.year, now.month, now.day + index),
                      ) &&
                  element.isCompleted == true)
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        }
        break;
      case TaskSortMode.incomplete:
        if (index == 0) {
          sortedList = tasks
              .where((element) =>
                  formatter.format(element.dueDate) ==
                      formatter.format(
                        DateTime.utc(now.year, now.month, now.day),
                      ) &&
                  element.isCompleted == false)
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        }
        if (index == 1) {
          sortedList = tasks
              .where((element) =>
                  formatter.format(element.dueDate) ==
                      formatter.format(
                        DateTime.utc(now.year, now.month, now.day + 1),
                      ) &&
                  element.isCompleted == false)
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        } else {
          sortedList = tasks
              .where((element) =>
                  formatter.format(element.dueDate) ==
                      formatter.format(
                        DateTime.utc(now.year, now.month, now.day + index),
                      ) &&
                  element.isCompleted == false)
              .toList();
          sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        }
        break;
      default:
    }
    return sortedList;
  }
}
