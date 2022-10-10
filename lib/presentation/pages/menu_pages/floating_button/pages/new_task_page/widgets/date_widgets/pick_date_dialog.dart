import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/widget.dart';

Future<void> showCalendarDatePicker({
  required BuildContext context,
  required BaseTasksController taskController,
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
          width: 300, //350
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AdvancedCalendar(
                  canExtend: false,
                  useShadow: false,
                  isMonth: true,
                  events: const [],
                  innerDot: false,
                  controller: taskController.pickedDate,
                ),
                ConfirmButtonWidget(
                  width: 170,
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
