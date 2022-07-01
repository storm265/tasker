import 'package:todo2/database/database_scheme/project_user_scheme.dart';

class ProjectModel {
  String title;
  String color;
  String uuid;
  int ownerId;
  String createdAt;

  
  ProjectModel({
    required this.title,
    required this.color,
    required this.createdAt,
    required this.ownerId,
    required this.uuid,
  });
   factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        title: json[ProjectDataScheme.title],
        color: json[ProjectDataScheme.color],
        createdAt: json[ProjectDataScheme.createdAt],
ownerId: json[ProjectDataScheme.ownerId],
        uuid: json[ProjectDataScheme.uuid],
      );
}
