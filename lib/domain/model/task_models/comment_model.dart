import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/domain/model/task_models/comment_attachment_model.dart';
import 'package:todo2/schemas/database_scheme/task_schemes/comment_attachment_scheme.dart';

class CommentModel {
  final String id;
  final String content;
  final String taskId;
  final String ownerId;
  final UserProfileModel? commentator;
  final List<CommentAttachmentModel>? attachments;
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
        taskId: json[CommentAttachmentScheme.taskId],
        commentator: json[CommentAttachmentScheme.commentator] == null
            ? null
            : UserProfileModel.fromJson(
                json[CommentAttachmentScheme.commentator]
                    as Map<String, dynamic>,
              ),
        attachments: json[CommentAttachmentScheme.attachments] == null
            ? null
            : (json[CommentAttachmentScheme.attachments] as List<dynamic>)
                .map((e) => CommentAttachmentModel.fromJson(e))
                .toList(),
        ownerId: json[CommentAttachmentScheme.ownerId],
        createdAt: DateTime.parse(
          '${json[CommentAttachmentScheme.createdAt]}' 'Z',
        ).toLocal(),
      );
}
