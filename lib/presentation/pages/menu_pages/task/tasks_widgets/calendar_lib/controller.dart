import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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

  final calendarMode = ValueNotifier<TaskMode>(TaskMode.selectedDay);

  void updateTaskWorkMode(TaskMode newMode) {
    calendarMode.value = newMode;
    calendarMode.notifyListeners();
  }

  final selectedMonth = ValueNotifier<DateTime>(DateTime.now());
  void onChangeMonth(DateTime newDate) {
    selectedMonth.value = newDate;
    log('selectedMonth.value ${selectedMonth.value}');
    selectedMonth.notifyListeners();
  }
 
}
 