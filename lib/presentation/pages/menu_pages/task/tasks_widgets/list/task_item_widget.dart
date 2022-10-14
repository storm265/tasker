import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/circle_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/view_task.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

final timeNow = DateTime.now();

class TaskCardWidget extends StatelessWidget {
  final TaskModel model;
  final TaskListController taskController;
  const TaskCardWidget({
    Key? key,
    required this.model,
    required this.taskController,
  }) : super(key: key);

  bool _isSoonExpire(DateTime deadLineTime) {
    if (DateFormat('yyyy-MM-dd').format(deadLineTime) ==
            DateFormat('yyyy-MM-dd').format(
                DateTime.utc(timeNow.year, timeNow.month, timeNow.day)) &&
        deadLineTime.difference(timeNow).inHours >= 0 &&
        deadLineTime.difference(timeNow).inHours <= 2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = model.dueDate;
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) => ViewTask(
            taskListController: taskController,
            pickedTask: model,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: _isSoonExpire(date)
                ? const Color(0xFFFFFFEF).withOpacity(0.7)
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E0E0).withOpacity(0.5),
                offset: const Offset(5, 5),
                blurRadius: 9,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                left: 357,
                child: SizedBox(
                  width: 4,
                  height: 25,
                  child: ColoredBox(
                    color: model.isCompleted
                        ? Colors.red
                        : getAppColor(color: CategoryColor.blue),
                  ),
                ),
              ),
              ListTile(
                leading: model.isCompleted
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.check_circle, color: Palette.red),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomPaint(
                          size: const Size(20, 20),
                          painter: CirclePainter(
                            circleColor: getAppColor(color: CategoryColor.blue),
                          ),
                        ),
                      ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    model.title,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      decoration:
                          model.isCompleted ? TextDecoration.lineThrough : null,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: model.isCompleted ? Colors.grey : null,
                    ),
                  ),
                ),
                subtitle: Text(
                  DateFormat.jm().format(date).toLowerCase(),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    decoration:
                        model.isCompleted ? TextDecoration.lineThrough : null,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
