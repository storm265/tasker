import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/grey_container.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/pick_date_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class PickTimeFieldWidget extends StatelessWidget {
  const PickTimeFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addTaskController = InheritedNewTaskController.of(context).addTaskController;
    
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
                  valueListenable: addTaskController.pickedTime,
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
