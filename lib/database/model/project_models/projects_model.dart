import 'package:flutter/cupertino.dart';
import 'package:todo2/database/database_scheme/project_schemes/project_user_scheme.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class ProjectModel {
  String id;
  String title;
  Color color;
  String ownerId;
  DateTime createdAt;

  ProjectModel({
    required this.id,
    required this.title,
    required this.color,
    required this.createdAt,
    required this.ownerId,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id:  json[ProjectDataScheme.id],
      title: json[ProjectDataScheme.title],
      color: Color(
        int.parse(
            json[ProjectDataScheme.color].toString().replaceColorSymbol()),
      ),
      createdAt: DateTime.parse(json[ProjectDataScheme.createdAt]),
      ownerId: json[ProjectDataScheme.ownerId],
    );
  }
}
