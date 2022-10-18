import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';

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

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectUserDataImpl _projectDataSource;
  ProjectRepositoryImpl({required ProjectUserDataImpl projectDataSource})
      : _projectDataSource = projectDataSource;

  @override
  Future<ProjectModel> fetchOneProject({required String projectId}) async {
    final response =
        await _projectDataSource.fetchOneProject(projectId: projectId);

    return ProjectModel.fromJson(response);
  }

  @override
  Future<List<ProjectModel>> fetchAllProjects() async {
    final response = await _projectDataSource.fetchAllProjects();
    List<ProjectModel> projects = [];
    for (int i = 0; i < response.length; i++) {
      projects.add(ProjectModel.fromJson(response[i]));
    }
    return projects;
  }

  @override
  Future<ProjectModel> createProject({
    required Color color,
    required String title,
  }) async {
    final response = await _projectDataSource.createProject(
      color: color,
      title: title,
    );
    return ProjectModel.fromJson(response);
  }

  @override
  Future<List<ProjectModel>> searchProject({required String title}) async {
    final response = await _projectDataSource.searchProject(title: title);
    return response.map((json) => ProjectModel.fromJson(json)).toList();
  }

  @override
  Future<ProjectModel> updateProject({
    required ProjectModel projectModel,
    required String title,
    required Color color,
  }) async {
    final response = await _projectDataSource.updateProject(
      color: color,
      projectModel: projectModel,
      title: title,
    );
    return ProjectModel.fromJson(response);
  }

  @override
  Future<List<ProjectStatsModel>> fetchProjectStats() async {
    final response = await _projectDataSource.fetchProjectStats();
    List<ProjectStatsModel> statsModels = [];
    for (int i = 0; i < response.length; i++) {
      statsModels.add(ProjectStatsModel.fromJson(response[i]));
    }
    return statsModels;
  }

  @override
  Future<void> deleteProject({required ProjectModel projectModel}) async =>
      await _projectDataSource.deleteProject(projectModel: projectModel);
}
