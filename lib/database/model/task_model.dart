import 'package:todo2/database/database_scheme/task_scheme.dart';

class TaskModel {
  String title;
  String dueDate;
  String description;
  int assignedTo;
  bool isCompleted;
  int projectId;
  int ownerId;
  String createdAt;
  String uuid;

  TaskModel({
    required this.title,
    required this.dueDate,
    required this.description,
    required this.assignedTo,
    required this.isCompleted,
    required this.projectId,
    required this.ownerId,
    required this.createdAt,
    required this.uuid,
    
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json[TaskScheme.title],
        dueDate: json[TaskScheme.dueDate],
        description: json[TaskScheme.description],
        assignedTo: json[TaskScheme.assignedTo],
        isCompleted: json[TaskScheme.isCompleted],
        projectId: json[TaskScheme.projectId],
        ownerId: json[TaskScheme.ownerId],
        createdAt: json[TaskScheme.createdAt],
         uuid: json[TaskScheme.uuid],
      );
}
