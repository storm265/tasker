import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/attachments/profile_widget.dart';

class TaskAttachementWidget extends StatelessWidget {
  final ViewTaskController viewTaskController;
  final TaskModel pickedTask;
  const TaskAttachementWidget({
    Key? key,
    required this.viewTaskController,
    required this.pickedTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        itemCount:
            pickedTask.attachments == null ? 0 : pickedTask.attachments?.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          log('type ${pickedTask.attachments![index].type}');
          final timeAgo = DateTime.now()
              .difference(pickedTask.attachments![index].createdAt);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: pickedTask.assignedTo == null
                          ? null
                          : NetworkImage(
                              viewTaskController.user?.avatarUrl ?? 'url',
                              headers: viewTaskController.imageHeader,
                            ),
                      radius: 14,
                      backgroundColor: Colors.amber,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewTaskController.user?.username ?? 'Not assigned',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            getDaysAgo(timeAgo.inDays, timeAgo.inHours),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                pickedTask.attachments![index].type == "IMAGE"
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          pickedTask.attachments![index].url,
                          headers: viewTaskController.imageHeader,
                        ),
                      )
                    : Column(
                        children: [
                          const Icon(
                            Icons.file_present,
                            size: 40,
                            color: Colors.grey,
                          ),
                          Text(
                            pickedTask.attachments![index].name,
                            maxLines: null,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
