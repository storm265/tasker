import 'package:todo2/database/database_scheme/task_schemes/attachment_scheme.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';

class TaskAttachmentModel {
  final String id;
  final String url;
  final String? type;
  final String taskId;
  final List<UserProfileModel>? members;
  final String createdAt;

  TaskAttachmentModel({
    required this.id,
    required this.url,
    this.type,
    required this.taskId,
    this.members,
    required this.createdAt,
  });

  factory TaskAttachmentModel.fromJson(Map<String, dynamic> json) =>
      TaskAttachmentModel(
        id: json[AttachmentScheme.id],
        url: json[AttachmentScheme.url],
        type: json[AttachmentScheme.type],
        taskId: json[AttachmentScheme.taskId],
        members: (json[AttachmentScheme.members] as List<dynamic>)
            .map((e) => UserProfileModel.fromJson(e))
            .toList(),
        createdAt: json[AttachmentScheme.createdAt],
      );
}
