import 'package:todo2/database/database_scheme/comment_attachment_scheme.dart';

class CommentAattachmentModel {
  final String commentId;
  final String url;
  final String createdAt;

  CommentAattachmentModel({
    required this.commentId,
    required this.createdAt,
    required this.url,
  });

  factory CommentAattachmentModel.fromJson(Map<String, dynamic> json) =>
      CommentAattachmentModel(
        commentId: json[CommentAttachmentScheme.commentId],
        url: json[CommentAttachmentScheme.url],
        createdAt: json[CommentAttachmentScheme.createdAt],
      );
}
