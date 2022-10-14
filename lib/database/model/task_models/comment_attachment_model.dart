import 'package:todo2/database/database_scheme/task_schemes/comment_attachment_scheme.dart';

class CommentAttachment {
  final String id;
  final String commentId;
  final String filePath;
  final String type;
  final DateTime createdAt;

  CommentAttachment({
    required this.id,
    required this.commentId,
    required this.filePath,
    required this.type,
    required this.createdAt,
  });

  factory CommentAttachment.fromJson(Map<String, dynamic> json) =>
      CommentAttachment(
        id: json[CommentAttachmentScheme.id],
        commentId: json[CommentAttachmentScheme.commentId],
        filePath: json[CommentAttachmentScheme.filePath],
        type: json[CommentAttachmentScheme.type],
        createdAt: DateTime.parse(json[CommentAttachmentScheme.createdAt]),
      );
}
