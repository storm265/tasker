import 'package:todo2/database/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/task_models/task_attachments_model.dart';

class TaskModel {
  final String id;
  final String title;
  final DateTime dueDate;
  final String description;
  final String assignedTo;
  final bool isCompleted;
  final String projectId;
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
        dueDate: DateTime.parse(json[TaskScheme.dueDate] ??
            "${DateTime.now().year + 30}-06-21T23:56:02.394631"),
        description: json[TaskScheme.description],
        assignedTo: json[TaskScheme.assignedTo],
        isCompleted: json[TaskScheme.isCompleted],
        projectId: json[TaskScheme.projectId],
        ownerId: json[TaskScheme.ownerId],
        createdAt: DateTime.parse(json[TaskScheme.createdAt]),
        attachments: json[TaskScheme.attachments] == null
            ? []
            : (json[TaskScheme.attachments] as List<dynamic>)
                .map((e) => TaskAttachmentModel.fromJson(e))
                .toList(),
        members: json[TaskScheme.members] == null
            ? []
            : (json[TaskScheme.members] as List<dynamic>)
                .map((e) => UserProfileModel.fromJson(e))
                .toList(),
      );

  TaskModel copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    String? description,
    String? assignedTo,
    bool? isCompleted,
    String? projectId,
    String? ownerId,
    DateTime? createdAt,
    List<TaskAttachmentModel>? attachments,
    List<UserProfileModel>? members,
  }) =>
      TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        dueDate: dueDate ?? this.dueDate,
        description: description ?? this.description,
        assignedTo: assignedTo ?? this.assignedTo,
        isCompleted: isCompleted ?? this.isCompleted,
        projectId: projectId ?? this.projectId,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
        attachments: attachments ?? this.attachments,
        members: members ?? this.members,
      );

  Map<String, dynamic> toMap() {
    return {
      TaskScheme.id: id,
      TaskScheme.title: title,
      TaskScheme.dueDate: dueDate,
      TaskScheme.description: description,
      TaskScheme.assignedTo: assignedTo,
      TaskScheme.isCompleted: isCompleted,
      TaskScheme.projectId: projectId,
      TaskScheme.ownerId: ownerId,
      TaskScheme.createdAt: createdAt,
      TaskScheme.attachments: attachments,
      TaskScheme.members: members,
    };
  }
}
