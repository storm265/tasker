
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/attachments/day_ago.dart';

class CommentAttachmentWidget extends StatelessWidget {
  final ViewTaskController viewTaskController;
  final TaskModel pickedTask;

  const CommentAttachmentWidget({
    super.key,
    required this.viewTaskController,
    required this.pickedTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 2,
      ),
      child: FutureBuilder<List<CommentModel>>(
        future: viewTaskController.fetchTaskComments(taskId: pickedTask.id),
        builder: ((_, AsyncSnapshot<List<CommentModel>> snapshot) {
          final list = snapshot.data ?? [];
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) {
              final model = list[i];
              final timeAgo = DateTime.now().difference(list[i].createdAt);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: pickedTask.assignedTo == null
                              ? null
                              : NetworkImage(
                                  list[i].commentator?.avatarUrl ?? '',
                                  headers: viewTaskController.imageHeader,
                                ),
                          radius: 14,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[i].commentator?.username ?? '',
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
                      padding: const EdgeInsets.only(top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          list[i].content,
                          maxLines: null,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.attachments?.length ?? 0,
                          itemBuilder: (_, index) {
                            return model.attachments![index].type == "IMAGE"
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        list[i].attachments![index].url,
                                        headers: viewTaskController.imageHeader,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.file_present,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          model.attachments![index].name,
                                          maxLines: null,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
