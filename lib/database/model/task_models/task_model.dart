import 'package:todo2/database/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/task_models/task_attachments_model.dart';

class TaskModel {
  final String id;
  final String title;
  final DateTime dueDate;
  final String description;
  final int assignedTo;
  final bool isCompleted;
  final int projectId;
  final String ownerId;
  final DateTime createdAt;
  final List<TaskAttachmentModel>? attachments;
  final List<UserProfileModel>? members;

  TaskModel({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.description,
    required this.assignedTo,
    required this.isCompleted,
    required this.projectId,
    required this.ownerId,
    required this.createdAt,
    this.attachments,
    this.members,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json[TaskScheme.id],
        title: json[TaskScheme.title],
        dueDate: DateTime.parse(json[TaskScheme.dueDate]),
        description: json[TaskScheme.description],
        assignedTo: json[TaskScheme.assignedTo],
        isCompleted: json[TaskScheme.isCompleted],
        projectId: json[TaskScheme.projectId],
        ownerId: json[TaskScheme.ownerId],
        createdAt: DateTime.parse(json[TaskScheme.createdAt]),
        attachments: (json[TaskScheme.attachments] as List<dynamic>)
            .map((e) => TaskAttachmentModel.fromJson(e))
            .toList(),
        members: (json[TaskScheme.members] as List<dynamic>)
            .map((e) => UserProfileModel.fromJson(e))
            .toList(),
      );
}
