import 'package:todo2/database/database_scheme/project_schemes/project_stats_scheme.dart';

class ProjectStatsModel {
  final String projectId;
  final int tasksNumber;

  ProjectStatsModel({
    required this.projectId,
    required this.tasksNumber,
  });

  factory ProjectStatsModel.fromJson(Map<String, dynamic> json) =>
      ProjectStatsModel(
        projectId: json[ProjectStatsScheme.projectId],
        tasksNumber: json[ProjectStatsScheme.tasksNumber],
      );
}
