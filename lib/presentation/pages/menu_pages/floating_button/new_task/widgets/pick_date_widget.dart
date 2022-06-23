import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/src/shared/utils.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/src/table_calendar.dart';

Future<void> showCalendarDatePicker(BuildContext context) async {
  DateTime selectedDay = DateTime.now();

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
                    return isSameDay(selectedDay, day);
                  },
                  onDaySelected: (selecDay, focusedDay) {
                    setState(() {
                      selectedDay = selecDay;
                      newTaskConroller.pickTime(selectedDay);
                    });
                  },
                  firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: selectedDay,
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
