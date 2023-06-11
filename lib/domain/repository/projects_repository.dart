import 'package:flutter/material.dart';
import 'package:todo2/domain/model/project_models/project_stats_model.dart';
import 'package:todo2/domain/model/project_models/projects_model.dart';

abstract class ProjectRepository {
  Future<ProjectModel> fetchOneProject({required String projectId});

  Future<List<ProjectModel>> fetchAllProjects();

  Future<ProjectModel> createProject({
    required Color color,
    required String title,
  });

  Future<void> deleteProject({required ProjectModel projectModel});

  Future<ProjectModel> updateProject({
    required ProjectModel projectModel,
    required String title,
    required Color color,
  });

  Future<List<ProjectStatsModel>> fetchProjectStats();

  Future<List<ProjectModel>> searchProject({required String title});
}
