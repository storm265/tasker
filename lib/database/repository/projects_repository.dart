import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/data_source/projects_user_data_source.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class ProjectRepository<T> {
  Future fetchProject();

  Future postProject({required String color, required String title});

  Future fetchProjectId({required String project});

  Future fetchProjectsWhere({required String title});

  Future deleteProject({required ProjectModel projectModel});

  Future updateProject({
    required String color,
    required String title,
    required String oldTitle,
  });

  Future findDublicates({required String title});
}

class ProjectRepositoryImpl implements ProjectRepository<ProjectModel> {
  final _projectDataSource = ProjectUserDataImpl();
  @override
  Future<List<ProjectModel>> fetchProject() async {
    try {
      final response = await _projectDataSource.fetchProject();
      return (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProject() repository $e');
      rethrow;
    }
  }

  @override
  Future<void> postProject({
    required String color,
    required String title,
  }) async {
    try {
      await _projectDataSource.postProject(color: color, title: title);
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl postProject() repository $e');
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
          'Error in ProjectRepositoryImpl fetchProjectsWhere() : $e');
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
          'Error in ProjectRepositoryImpl fetchProjectId() : $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse> updateProject({
    required String color,
    required String title,
    required String oldTitle,
  }) async {
    try {
      final response = await _projectDataSource.updateProject(
          color: color, title: title, oldTitle: oldTitle);
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl removeProject() : $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> deleteProject(
      {required ProjectModel projectModel}) async {
    try {
      final response =
          await _projectDataSource.deleteProject(projectModel: projectModel);
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl removeProject() : $e');
      rethrow;
    }
  }

  @override
  Future<String> findDublicates({required String title}) async {
    try {
      log('title in repo $title');
      final response = await _projectDataSource.findDublicates(title: title);
      if (response.data.toString().length == 2) {
        return 'no';
      } else {
        return response.data[0][ProjectDataScheme.title];
      }
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl findDublicates() : $e');
      rethrow;
    }
  }
}
