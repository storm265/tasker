import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo2/data/data_source/project/project_data_source_impl.dart';
import 'package:todo2/domain/model/project_models/project_stats_model.dart';
import 'package:todo2/domain/model/project_models/projects_model.dart';
import 'package:todo2/database/scheme/projects/project_dao.dart';
import 'package:todo2/database/scheme/projects/project_database.dart';
import 'package:todo2/services/cache_service/cache_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

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
  final InMemoryCache _inMemoryCache;
  final ProjectDao _projectDao;
  final ProjectUserDataSourceImpl _projectDataSource;
  ProjectRepositoryImpl({
    required ProjectUserDataSourceImpl projectDataSource,
    required ProjectDao projectDao,
    required InMemoryCache inMemoryCache,
  })  : _projectDataSource = projectDataSource,
        _projectDao = projectDao,
        _inMemoryCache = inMemoryCache;

  @override
  Future<ProjectModel> fetchOneProject({required String projectId}) async {
    final response =
        await _projectDataSource.fetchOneProject(projectId: projectId);

    return ProjectModel.fromJson(response);
  }

  @override
  Future<List<ProjectModel>> fetchAllProjects() async {
    List<ProjectModel> projects = [];
    if (_inMemoryCache.shouldFetchOnlineData(
        date: DateTime.now(), key: CacheKeys.menu)) {
      final response = await _projectDataSource.fetchAllProjects();

      await _projectDao.deleteAllProjects();
      for (int i = 0; i < response.length; i++) {
        projects.add(ProjectModel.fromJson(response[i]));
        await _projectDao.insertProject(
          ProjectTableCompanion(
            color: Value(projects[i].color.toString().toStringColor()),
            title: Value(projects[i].title),
            createdAt: Value(projects[i].createdAt.toIso8601String()),
            id: Value(projects[i].id),
            ownerId: Value(projects[i].ownerId),
          ),
        );
      }

      return projects;
    } else {
      final list = await _projectDao.getProjects();

      for (int i = 0; i < list.length; i++) {
        projects.add(ProjectModel.fromJson(list[i].toJson()));
      }

      return projects;
    }
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
