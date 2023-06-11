import 'package:flutter/material.dart';
import 'package:todo2/domain/model/project_models/projects_model.dart';

abstract class ProjectUserDataSource {
  Future<void> updateProject({
    required ProjectModel projectModel,
    required Color color,
    required String title,
  });

  Future<void> deleteProject({
    required ProjectModel projectModel,
  });

  Future<Map<String, dynamic>> createProject({
    required Color color,
    required String title,
  });

  Future<List<dynamic>> searchProject({required String title});

  Future<Map<String, dynamic>> fetchOneProject({required String projectId});

  Future<List<dynamic>> fetchAllProjects();

  Future<List<dynamic>> fetchProjectStats();
}
