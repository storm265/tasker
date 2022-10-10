import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class ProjectRepository {
  // Future fetchOneProject();

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

  // @override
  // Future<ProjectModel> fetchOneProject() async {
  //   final response = await _projectDataSource.fetchOneProject();
  //   //  return response.data[ProjectDataScheme.data];
  //   return ProjectModel(
  //     id: '',
  //     color: Colors.red,
  //     createdAt: DateTime.now(),
  //     ownerId: '',
  //     title: '',
  //   );
  // }

  @override
  Future<List<ProjectModel>> fetchAllProjects() async {
    try {
      final response = await _projectDataSource.fetchAllProjects();
      List<ProjectModel> projects = [];
      for (int i = 0; i < response.length; i++) {
        projects.add(ProjectModel.fromJson(response[i]));
      }
      return projects;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<ProjectModel> createProject({
    required Color color,
    required String title,
  }) async {
    try {
      final response = await _projectDataSource.createProject(
        color: color,
        title: title,
      );
      return ProjectModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<ProjectModel>> searchProject({required String title}) async {
    try {
      final response = await _projectDataSource.searchProject(title: title);
      return response.map((json) => ProjectModel.fromJson(json)).toList();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<ProjectModel> updateProject({
    required ProjectModel projectModel,
    required String title,
    required Color color,
  }) async {
    try {
      final response = await _projectDataSource.updateProject(
        color: color,
        projectModel: projectModel,
        title: title,
      );
      return ProjectModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<ProjectStatsModel>> fetchProjectStats() async {
    try {
      final response = await _projectDataSource.fetchProjectStats();
      List<ProjectStatsModel> statsModels = [];
      for (int i = 0; i < response.length; i++) {
        statsModels.add(ProjectStatsModel.fromJson(response[i]));
      }
      return statsModels;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteProject({required ProjectModel projectModel}) async {
    try {
      await _projectDataSource.deleteProject(projectModel: projectModel);
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
