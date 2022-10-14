import 'package:todo2/database/database_scheme/task_schemes/comment_attachment_scheme.dart';

class CommentModel {
  final String id;
  final String content;
  final String taskId;
  final String ownerId;
  final String commenter;
  final String avatarUrl;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.taskId,
    required this.commenter,
    required this.ownerId,
    required this.avatarUrl,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json[CommentAttachmentScheme.id],
        content: json[CommentAttachmentScheme.content],
        commenter: json[CommentAttachmentScheme.commenter],
        taskId: json[CommentAttachmentScheme.taskId],
        ownerId: json[CommentAttachmentScheme.ownerId],
        avatarUrl: json[CommentAttachmentScheme.avatarUrl],
        createdAt: DateTime.parse(json[CommentAttachmentScheme.createdAt]),
      );
}
