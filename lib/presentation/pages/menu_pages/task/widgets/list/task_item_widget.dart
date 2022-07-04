import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/circle_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel data;
  const TaskCardWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(data.dueDate);
    String isAm = (date.hour > 12) ? 'pm' : 'am';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 366,
              child: SizedBox(
                width: 5,
                height: 25,
                child: ColoredBox(
                  color: data.isCompleted ? colors[0] : Colors.red,
                ),
              ),
            ),
            ListTile(
              leading: data.isCompleted
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.check_circle, color: Palette.red),
                    )
                  : CustomPaint(
                      size: const Size(20, 20),
                      painter: CirclePainter(circleColor: colors[0]),
                    ),
              subtitle: Text(
                '${date.hour}:${date.minute} $isAm',
                style: data.isCompleted
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              title: Text(
                data.title,
                style: data.isCompleted
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
