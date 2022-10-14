import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';

class TaskAttachementWidget extends StatelessWidget {
  final ViewTaskController viewTaskController;
  final TaskModel pickedModel;

  const TaskAttachementWidget({
    super.key,
    required this.viewTaskController,
    required this.pickedModel,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewTaskController.fetchComments(taskId: pickedModel.id),
      builder: ((_, AsyncSnapshot<List<CommentModel>> snapshot) {
        final data = snapshot.data ?? [];
        return ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) {
            int daysAgo = DateTime.now()
                .difference(pickedModel.attachments![i].createdAt)
                .inDays;
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      data[i].avatarUrl,
                      headers: viewTaskController.imageHeader,
                    ),
                    radius: 20,
                  ),
                  title: Text(
                    data[i].commentator.username,
                    style: const TextStyle(
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
                Text(
                  data[i].content,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
