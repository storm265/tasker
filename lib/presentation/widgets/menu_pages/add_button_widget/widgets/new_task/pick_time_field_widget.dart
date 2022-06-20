import 'package:flutter/material.dart';
import 'package:todo2/controller/add_tasks/add_task/add__task_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/new_task/grey_container.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/new_task/pick_date_widget.dart';

class PickTimeFieldWidget extends StatelessWidget {
  const PickTimeFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: ValueListenableBuilder<DateTime?>(
                  valueListenable: newTaskConroller.pickedTime,
                  builder: (context, time, _) => ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors[0]),
                    onPressed: () => showCalendarDatePicker(context),
                    child: Text(
                      time == null
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
