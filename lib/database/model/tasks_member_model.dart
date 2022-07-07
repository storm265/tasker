import 'package:todo2/database/database_scheme/tasks_member_scheme.dart';

class TasksMemberModel {
  final String createdAt;

  TasksMemberModel({required this.createdAt});

  factory TasksMemberModel.fromJson(Map<String, dynamic> json) =>
      TasksMemberModel(createdAt: json[TasksMemberScheme.createdAt]);
}
