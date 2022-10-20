import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/database/model/task_models/task_model.dart';

enum TaskMode {
  todayTomorrow, // only 2 days (today - tomorrow)
  selectedDay, // only 1 selected day
  fullMonth, // if opened month
}

enum TasksSortMode {
  incomplete,
  completed,
  all,
}

// LocaleKeys.today.tr()
// {LocaleKeys.tomorrow.tr()
// TODO refactor
class TaskSortController {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  List<TaskModel> sortedList = [];

  List<TaskModel> sorter({
    required List<TaskModel> tasks,
    required int index,
    TasksSortMode taskSortMode = TasksSortMode.all,
  }) {
    switch (taskSortMode) {
      case TasksSortMode.all:
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

      case TasksSortMode.completed:
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
      case TasksSortMode.incomplete:
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
