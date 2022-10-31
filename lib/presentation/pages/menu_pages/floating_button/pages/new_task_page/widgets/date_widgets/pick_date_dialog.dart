import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/widget.dart';

Future<void> showCalendarDatePicker({
  required BuildContext context,
  required BaseTasks taskController,
}) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        content: SizedBox(
          height: 350,
          width: 300,
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AdvancedCalendar(
                  calendarProvider: CalendarProvider(
                    canExtend: false,
                    isMonthMode: true,
                  ),
                  useShadow: false,
                  events: const [],
                  innerDot: false,
                  controller: taskController.calendarController,
                ),
                ConfirmButtonWidget(
                  width: 170,
                  onPressed: () {
                    if (taskController.taskValidator.isValidPickedDate(
                      taskController.calendarController.value,
                      context,
                      true,
                    )) {
                      Navigator.pop(context);
                    }
                  },
                  title: LocaleKeys.done.tr(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
