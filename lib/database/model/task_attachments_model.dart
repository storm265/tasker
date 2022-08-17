import 'package:todo2/database/database_scheme/task_attachments_scheme.dart';

class TaskAttachmentModel {
  final String taskId;
  final String url;
  final String createdAt;

  TaskAttachmentModel({
    required this.createdAt,
    required this.taskId,
    required this.url,
  });

  factory TaskAttachmentModel.fromJson(Map<String, dynamic> json) =>
      TaskAttachmentModel(
        url: json[TaskAttachmentsScheme.url],
        taskId: json[TaskAttachmentsScheme.taskId],
        createdAt: json[TaskAttachmentsScheme.createdAt],
      );
}
