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

final monthPattern = DateFormat('yyyy-MM');
final todayPattern = DateFormat('yyyy-MM-dd');

// LocaleKeys.today.tr()
// {LocaleKeys.tomorrow.tr()
// TODO refactor
class TaskSortController {
  final now = DateTime.now();

  List<TaskModel> sortList(
    TaskMode calendarMode,
    List<TaskModel> list,
  ) {
    final now = DateTime.now();

    switch (calendarMode) {
      case TaskMode.fullMonth:
        // TODO NOT NOW
        return list
            .where((element) =>
                monthPattern.format(element.dueDate) ==
                monthPattern.format(now))
            .toList();
      case TaskMode.selectedDay:
        return list
            .where((element) =>
                todayPattern.format(element.dueDate) ==
                todayPattern.format(now))
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
}
