import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/attachments/day_ago.dart';

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
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 2,
      ),
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
                            viewTaskController.user?.username ??
                                LocaleKeys.not_assigned.tr(),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: pickedTask.attachments![index].type == "IMAGE"
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
