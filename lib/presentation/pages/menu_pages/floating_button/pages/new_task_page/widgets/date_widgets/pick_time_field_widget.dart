import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/common/grey_container.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/date_widgets/pick_date_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class PickTimeFieldWidget extends StatefulWidget {
  final BaseTasksController addEditTaskController;
  const PickTimeFieldWidget({
    Key? key,
    required this.addEditTaskController,
  }) : super(key: key);

  @override
  State<PickTimeFieldWidget> createState() => _PickTimeFieldWidgetState();
}

class _PickTimeFieldWidgetState extends State<PickTimeFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return UnfocusWidget(
      child: GreyContainerWidget(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  LocaleKeys.due_date.tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 110,
                  height: 35,
                  child: ValueListenableBuilder<DateTime>(
                      valueListenable: widget.addEditTaskController.pickedDate,
                      builder: (context, time, _) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  getAppColor(color: CategoryColor.blue)),
                          onPressed: () async => await showCalendarDatePicker(
                            context: context,
                            taskController: widget.addEditTaskController,
                          ).then((_) => setState(() {})),
                          child: Text(
                            maxLines: null,
                            widget.addEditTaskController.taskValidator
                                        .isValidPickedDate(
                                      widget.addEditTaskController.pickedDate
                                          .value,
                                      context,
                                      false,
                                    ) ==
                                    true
                                ? '${time.day}/${time.month}/${time.year}'
                                : LocaleKeys.anytime.tr(),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
