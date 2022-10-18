import 'dart:developer';
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

// TODO paste same code to task attachment
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 2,
      ),
      child: FutureBuilder(
        future: viewTaskController.fetchComments(taskId: pickedTask.id),
        builder: ((_, AsyncSnapshot<List<CommentModel>> snapshot) {
          final data = snapshot.data ?? [];
          data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          log('comments ${data.length}');
          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) {
              final timeAgo = DateTime.now().difference(data[i].createdAt);
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
                                  data[i].commentator?.avatarUrl ?? '',
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
                                data[i].commentator?.username ?? '',
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
                          data[i].content,
                          maxLines: null,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    // pickedTask.attachments![i].type == "IMAGE"
                    //     ? ClipRRect(
                    //         borderRadius: BorderRadius.circular(5),
                    //         child: Image.network(
                    //           data[i].commentator.avatarUrl,
                    //           headers: viewTaskController.imageHeader,
                    //         ),
                    //       )
                    //     : Column(
                    //         children: [
                    //           const Icon(
                    //             Icons.file_present,
                    //             size: 40,
                    //             color: Colors.grey,
                    //           ),
                    //           Text(
                    //             pickedTask.attachments![i].name,
                    //             maxLines: null,
                    //             style: const TextStyle(
                    //               overflow: TextOverflow.ellipsis,
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: 12,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
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
