import 'package:flutter/material.dart';
import 'package:todo2/controller/add_tasks/add_task/add__task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/calendar_lib/src/shared/utils.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/calendar_lib/src/table_calendar.dart';

Future<void> showCalendarDatePicker(BuildContext context) async {
  DateTime _selectedDay = DateTime.now();

  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        content: SizedBox(
          height: 400,
          width: 350,
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TableCalendar(
                  shouldHideButton: true,
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      newTaskConroller.pickTime(_selectedDay);
                    });
                  },
                  firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _selectedDay,
                ),
                ConfirmButtonWidget(
                  width: 150,
                  onPressed: () => Navigator.pop(context),
                  title: 'Done',
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
