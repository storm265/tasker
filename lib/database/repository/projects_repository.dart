import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class ProjectRepository<T> {
  Future fetchOneProject();

  Future createProject({
    required Color color,
    required String title,
  });

  Future fetchProjectId({required String project});

  Future fetchProjectsWhere({required String title});

  Future deleteProject({required ProjectModel projectModel});

  Future updateProject({
    required Color color,
    required String title,
    required String oldTitle,
  });

  Future findDublicates({required String title});
}

class ProjectRepositoryImpl implements ProjectRepository<ProjectModel> {
  final _projectDataSource = ProjectUserDataImpl(
    secureStorageService: SecureStorageService(),
  );

  @override
  Future<Map<String, dynamic>> fetchOneProject() async {
    try {
      final response = await _projectDataSource.fetchOneProject();
      return response.data[ProjectDataScheme.data];
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProject() $e');
      rethrow;
    }
  }

  @override
  Future<void> createProject({
    required Color color,
    required String title,
  }) async {
    try {
      await _projectDataSource.createProject(color: color, title: title);
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl postProject() $e');
      rethrow;
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjectsWhere({required String title}) async {
    try {
      final response =
          await _projectDataSource.fetchProjectsWhere(title: title);
      return (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProjectsWhere(): $e');
      rethrow;
    }
  }

  @override
  Future<int> fetchProjectId({required String project}) async {
    try {
      final response =
          await _projectDataSource.fetchProjectId(project: project);
      return response.data[0][ProjectDataScheme.id];
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProjectId(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> updateProject({
    required Color color,
    required String title,
    required String oldTitle,
  }) async {
    try {
      final response = await _projectDataSource.updateProject(
        color: color,
        title: title,
        oldTitle: oldTitle,
      );
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl removeProject(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> deleteProject(
      {required ProjectModel projectModel}) async {
    try {
      final response =
          await _projectDataSource.deleteProject(projectModel: projectModel);
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl removeProject(): $e');
      rethrow;
    }
  }

  @override
  Future<String> findDublicates({required String title}) async {
    try {
      final response = await _projectDataSource.findDublicates(title: title);
      if (response.data.toString().length == 2) {
        return 'no';
      } else {
        return response.data[0][ProjectDataScheme.title];
      }
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl findDublicates(): $e');
      rethrow;
    }
  }
}
