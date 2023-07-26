import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/domain/model/task_models/task_model.dart';
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

class TaskSortProvider {
  final _now = DateTime.now();

  int _calculateDifferenceInDays(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(_now.year, _now.month, _now.day))
        .inDays;
  }

  List<TaskModel> sortList(
    TaskMode calendarMode,
    List<TaskModel> list,
    DateTime? selectedDay,
  ) {
    switch (calendarMode) {
      case TaskMode.fullMonth:
        return list
            .where(
              (element) =>
                  monthPattern.format(element.dueDate) ==
                  monthPattern.format(
                    DateTime.utc(
                      _now.year,
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
                _calculateDifferenceInDays(element.dueDate) == 0 &&
                _calculateDifferenceInDays(element.dueDate) == 1)
            .toList();
    }
  }

  List<TaskModel> taskModeSort({
    required List<TaskModel> tasks,
    TasksSortMode taskSortMode = TasksSortMode.all,
  }) {
    List<TaskModel> sortedList = [];

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

  String formatDay(DateTime date) {
    final result = _calculateDifferenceInDays(date);
    switch (result) {
      case 0:
        return LocaleKeys.today.tr();
      case 1:
        return LocaleKeys.tomorrow.tr();
      default:
        return '';
    }
  }
}
