import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/grey_container.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/pick_date_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class PickTimeFieldWidget extends StatelessWidget {
  const PickTimeFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController =
        InheritedNewTaskController.of(context).addTaskController;
    return GreyContainerWidget(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text('Due Date'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 100,
                height: 35,
                child: ValueListenableBuilder<DateTime>(
                  valueListenable: taskController.pickedDate,
                  builder: (context, time, _) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            getAppColor(color: CategoryColor.blue)),
                    onPressed: () async =>
                        await showCalendarDatePicker(context),
                    child: Text(
                      time.day == DateTime.now().day
                          ? 'Anytime'
                          : '${time.day}/${time.month}/${time.year}',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
