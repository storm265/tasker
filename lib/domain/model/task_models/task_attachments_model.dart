import 'package:todo2/schemas/database_scheme/task_schemes/attachment_scheme.dart';

class TaskAttachmentModel {
  final String id;
  final String url;
  final String name;
  final String type;
  final String taskId;
  final DateTime createdAt;

  TaskAttachmentModel({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.taskId,
    required this.createdAt,
  });

  factory TaskAttachmentModel.fromJson(Map<String, dynamic> json) {
    return TaskAttachmentModel(
      id: json[AttachmentScheme.id],
      url: json[AttachmentScheme.url],
      name: json[AttachmentScheme.name],
      type: json[AttachmentScheme.type],
      taskId: json[AttachmentScheme.taskId],
      createdAt: DateTime.parse(
        '${json[AttachmentScheme.createdAt]}' 'Z',
      ).toLocal(),
    );
  }
}
