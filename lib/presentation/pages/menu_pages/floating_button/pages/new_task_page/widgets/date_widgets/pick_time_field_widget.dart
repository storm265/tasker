import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/common/grey_container.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/date_widgets/pick_date_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class PickTimeFieldWidget extends StatefulWidget {
  final BaseTasks addEditTaskController;
  const PickTimeFieldWidget({
    Key? key,
    required this.addEditTaskController,
  }) : super(key: key);

  @override
  State<PickTimeFieldWidget> createState() => _PickTimeFieldWidgetState();
}

class _PickTimeFieldWidgetState extends State<PickTimeFieldWidget> {
  final dueDateFormatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return GreyContainerWidget(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                LocaleKeys.due_date.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 110,
                height: 35,
                child: ValueListenableBuilder<DateTime>(
                    valueListenable:
                        widget.addEditTaskController.calendarController,
                    builder: (__, time, _) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              getAppColor(color: CategoryColor.blue),
                        ),
                        onPressed: () async {
                          await showCalendarDatePicker(
                            context: context,
                            taskController: widget.addEditTaskController,
                          );
                        },
                        child: Text(
                          maxLines: null,
                          dueDateFormatter.format(time) ==
                                  dueDateFormatter.format(DateTime.now())
                              ? LocaleKeys.anytime.tr()
                              //     : dueDateFormatter.format(time),
                              : '${time.day}/${time.month}/${time.year}',
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
