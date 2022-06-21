import 'package:todo2/database/database_scheme/project_user_scheme.dart';

class ProjectModel {
  final String? title, color, createdAt, ownerId;

  ProjectModel({
    required this.title,
    required this.color,
    required this.createdAt,
    required this.ownerId,
  });
  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        title: json[UserDataScheme.title],
        color: json[UserDataScheme.color],
        createdAt: json[UserDataScheme.createdAt],
        ownerId: json[UserDataScheme.ownerId],
      );
}
