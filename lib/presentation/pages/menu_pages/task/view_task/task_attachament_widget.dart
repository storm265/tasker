import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';

class TaskAttachementWidget extends StatefulWidget {
  final ViewTaskController viewTaskController;
  final TaskModel pickedModel;
  const TaskAttachementWidget({
    Key? key,
    required this.viewTaskController,
    required this.pickedModel,
  }) : super(key: key);

  @override
  State<TaskAttachementWidget> createState() => _TaskAttachementWidgetState();
}

class _TaskAttachementWidgetState extends State<TaskAttachementWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.pickedModel.attachments == null
          ? 0
          : widget.pickedModel.attachments?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        int daysAgo = DateTime.now()
            .difference(widget.pickedModel.attachments![index].createdAt)
            .inDays;
        return Column(
          // TODO fetch some shit
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.amber,
              ),
              title: const Text(
                'title',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
              subtitle: Text(
                daysAgo.toString().length == 1
                    ? '$daysAgo ${LocaleKeys.day_ago.tr()}'
                    : '$daysAgo ${LocaleKeys.days_ago.tr()}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            widget.pickedModel.attachments![index].type == "IMAGE"
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      widget.pickedModel.attachments![index].url,
                      headers: widget.viewTaskController.imageHeader,
                    ),
                  )
                : Column(
                    children: const [
                      Icon(
                        Icons.file_present,
                        size: 40,
                        color: Colors.grey,
                      ),
                      Text(
                        'File name',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
