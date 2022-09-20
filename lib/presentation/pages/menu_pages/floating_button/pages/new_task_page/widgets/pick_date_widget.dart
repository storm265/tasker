import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/widget.dart';

Future<void> showCalendarDatePicker(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (_) {
      final addTaskController =
          InheritedNewTaskController.of(context).addTaskController;
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        content: SizedBox(
          height: 300,
          width: 350,
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
                  controller: addTaskController.pickedDate,
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
