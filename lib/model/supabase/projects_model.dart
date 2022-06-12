// ignore_for_file: non_constant_identifier_names

import 'package:todo2/database/database_scheme/project_user_scheme.dart';

class ProjectModel {
  final String? title, color, created_at, owner_id;

  ProjectModel({
    required this.title,
    required this.color,
    required this.created_at,
    required this.owner_id,
  });
  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        title: json[UserDataScheme.title] ?? 'empty',
        color: json[UserDataScheme.color] ?? 'empty',
        created_at: json[UserDataScheme.created_at] ?? 'empty',
        owner_id: json[UserDataScheme.owner_id] ?? 'empty',
      );
}
