import 'package:todo2/schemas/database_scheme/task_schemes/comment_attachment_scheme.dart';

class CommentAttachmentModel {
  final String id;
  final String url;
  final String type;
  final String commentId;
  final String name;

  final DateTime createdAt;

  CommentAttachmentModel({
    required this.id,
    required this.commentId,
    required this.url,
    required this.name,
    required this.type,
    required this.createdAt,
  });

  factory CommentAttachmentModel.fromJson(Map<String, dynamic> json) {
    return CommentAttachmentModel(
      id: json[CommentAttachmentScheme.id],
      url: json[CommentAttachmentScheme.url],
      commentId: json[CommentAttachmentScheme.commentId],
      name: json[CommentAttachmentScheme.name],
      type: json[CommentAttachmentScheme.type],
      createdAt: DateTime.parse(json[CommentAttachmentScheme.createdAt]),
    );
  }
}
