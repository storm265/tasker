import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/done_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/undone_item_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel data;
  const TaskCardWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            data.isCompleted
                ? DoneItemWidget(
                    subtitle: data.dueDate,
                    title: data.title,
                  )
                : UndoneItemWidget(
                    subtitle: data.dueDate,
                    title: data.title,
                  ),
          ],
        ),
      ),
    );
  }
}
