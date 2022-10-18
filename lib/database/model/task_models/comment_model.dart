import 'package:todo2/database/database_scheme/task_schemes/comment_attachment_scheme.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';

// TODO maybe should add attachaments field
class CommentModel {
  final String id;
  final String content;
  final String taskId;
  final String ownerId;
  final UserProfileModel? commentator;
  final String? attachments;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.taskId,
    required this.commentator,
    required this.ownerId,
    this.attachments,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json[CommentAttachmentScheme.id],
        content: json[CommentAttachmentScheme.content],
        commentator: json[CommentAttachmentScheme.commentator] == null
            ? null
            : UserProfileModel.fromJson(
                json[CommentAttachmentScheme.commentator]
                    as Map<String, dynamic>,
              ),
        taskId: json[CommentAttachmentScheme.taskId],
        attachments: json[CommentAttachmentScheme.attachments] ?? '',
        ownerId: json[CommentAttachmentScheme.ownerId],
        createdAt: DateTime.parse(
          json[CommentAttachmentScheme.createdAt],
        ),
      );
}
