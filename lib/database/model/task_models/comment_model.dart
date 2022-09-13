import 'package:todo2/database/database_scheme/task_schemes/comment_attachment_scheme.dart';

class CommentModel {
  final String id;
  final String content;
  final String taskId;
  final String ownerId;
  final String attachments;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.taskId,
    required this.ownerId,
    required this.attachments,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json[CommentAttachmentScheme.id],
        content: json[CommentAttachmentScheme.content],
        taskId: json[CommentAttachmentScheme.taskId],
        ownerId: json[CommentAttachmentScheme.ownerId],
        attachments: json[CommentAttachmentScheme.attachments],
        createdAt: DateTime.parse(json[CommentAttachmentScheme.createdAt]),
      );
}
