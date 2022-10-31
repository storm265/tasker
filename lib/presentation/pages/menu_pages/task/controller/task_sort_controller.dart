import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';

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

final monthPattern = DateFormat('yyyy-MM');
final todayPattern = DateFormat('yyyy-MM-dd');

// LocaleKeys.today.tr()
// {LocaleKeys.tomorrow.tr()
class TaskSortController {
  final now = DateTime.now();

  List<TaskModel> sortList(
      TaskMode calendarMode, List<TaskModel> list, DateTime? selectedDay) {
    switch (calendarMode) {
      case TaskMode.fullMonth:
        return list
            .where(
              (element) =>
                  monthPattern.format(element.dueDate) ==
                  monthPattern.format(
                    DateTime.utc(
                      now.year,
                      selectedDay!.month,
                    ),
                  ),
            )
            .toList();
      case TaskMode.selectedDay:
        return list
            .where((element) =>
                todayPattern.format(element.dueDate) ==
                todayPattern.format(selectedDay!))
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

  List<TaskModel> sortedList = [];
  List<TaskModel> taskModeSort({
    required List<TaskModel> tasks,
    TasksSortMode taskSortMode = TasksSortMode.all,
  }) {
    switch (taskSortMode) {
      case TasksSortMode.all:
        return tasks;

      case TasksSortMode.completed:
        sortedList =
            tasks.where((element) => element.isCompleted == true).toList();
        sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case TasksSortMode.incomplete:
        sortedList =
            tasks.where((element) => element.isCompleted == false).toList();
        sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      default:
    }
    return sortedList;
  }
// TODO finish
  bool isTomorrow(DateTime date) {
      log('difference  ${date.difference (monthPattern.format() == monthPattern.format() && date.day == now.day + 1)}');
    log('short equal ${(monthPattern.format(date) == monthPattern.format(now) && date.day == now.day + 1)}');
    if ((monthPattern.format(date) == monthPattern.format(now) &&
            date.day == now.day + 1) ||
        (date.year == now.year &&
            date.day == now.day + 1 &&
            date.month >= now.month + 1)) {
      log('its tomorrow ');
      return true;
    } else {
      log('not tomorrow ');
      return false;
    }
  }

  String formatDay(DateTime date) {
    if (todayPattern.format(date) == todayPattern.format(now)) {
      return LocaleKeys.today.tr();
    } else if (isTomorrow(date)) {
      return LocaleKeys.tomorrow.tr();
    } else {
      return '';
    }
  }
}
