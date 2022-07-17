import 'package:todo2/database/database_scheme/project_user_scheme.dart';

class ProjectModel {
  String title;
  String color;
  String ownerId;
  String createdAt;

  ProjectModel({
    this.title ='',
    this.color='',
    this.createdAt='',
    this.ownerId='',
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        title: json[ProjectDataScheme.title],
        color: json[ProjectDataScheme.color],
        createdAt: json[ProjectDataScheme.createdAt],
        ownerId: json[ProjectDataScheme.ownerId],
      );
}
