import 'package:flutter/widgets.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_controller.dart';
import 'datetime_util.dart';

class AdvancedCalendarController extends ValueNotifier<DateTime> {
  AdvancedCalendarController._(DateTime value) : super(value);

  AdvancedCalendarController.today() : this._(DateTime.now().toZeroTime());

  AdvancedCalendarController.custom(DateTime dateTime)
      : this._(dateTime.toZeroTime());

  @override
  set value(DateTime newValue) {
    super.value = newValue.toZeroTime();
  }
}


class CalendarProvider extends ChangeNotifier {
  CalendarProvider({
    this.isMonthMode = false,
    this.canExtend = true,
  });
  bool canExtend;
  bool isMonthMode;

  final calendarMode =
      ValueNotifier<CalendarWorkMode>(CalendarWorkMode.selectedDay);
  void updateTaskWorkMode(CalendarWorkMode newMode) {
    calendarMode.value = newMode;
    calendarMode.notifyListeners();
  }
}