import 'package:todo2/database/database_scheme/task_schemes/comment_attachment_scheme.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';

class CommentModel {
  final String id;
  final String content;
  final String taskId;
  final String ownerId;
  final UserProfileModel commentator;
  final String avatarUrl;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.taskId,
    required this.commentator,
    required this.ownerId,
    required this.avatarUrl,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json[CommentAttachmentScheme.id],
        content: json[CommentAttachmentScheme.content],
        commentator: UserProfileModel.fromJson(
            json[CommentAttachmentScheme.commenter] as Map<String, dynamic>),
        taskId: json[CommentAttachmentScheme.taskId],
        ownerId: json[CommentAttachmentScheme.ownerId],
        avatarUrl: json[CommentAttachmentScheme.avatarUrl],
        createdAt: DateTime.parse(
          json[CommentAttachmentScheme.createdAt],
        ),
      );
}
