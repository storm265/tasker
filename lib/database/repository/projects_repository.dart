import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class ProjectRepository {
  Future fetchOneProject();

  Future fetchAllProjects();

  Future createProject({
    required Color color,
    required String title,
  });

  Future fetchProjectsWhere({required String title});

  Future deleteProject({required ProjectModel projectModel});

  Future updateProject({
    required Color color,
    required String title,
  });

  Future isDublicatedProject({required String title});
}

class ProjectRepositoryImpl implements ProjectRepository {
  final _projectDataSource = ProjectUserDataImpl(
    secureStorageService: SecureStorageService(),
  );

  @override
  Future<BaseListResponse<ProjectModel>> fetchOneProject() async {
    final response = await _projectDataSource.fetchOneProject();
    return response.data[ProjectDataScheme.data];
  }

  @override
  Future<BaseListResponse<ProjectModel>> fetchAllProjects() async {
    final response = await _projectDataSource.fetchAllProjects();
    return response;
  }

  @override
  Future<void> createProject({
    required Color color,
    required String title,
  }) async {
    await _projectDataSource.createProject(
      color: color,
      title: title,
    );
  }

  @override
  Future<List<ProjectModel>> fetchProjectsWhere({required String title}) async {
    final response = await _projectDataSource.fetchProjectsWhere(title: title);
    return (response.data as List<dynamic>)
        .map((json) => ProjectModel.fromJson(json))
        .toList();
  }

  @override
  Future<BaseResponse<ProjectModel>> updateProject({
    required Color color,
    required String title,
  }) async {
    final response = await _projectDataSource.updateProject(
      color: color,
      title: title,
    );
    return response;
  }

  @override
  Future<Response<dynamic>> deleteProject(
      {required ProjectModel projectModel}) async {
    final response =
        await _projectDataSource.deleteProject(projectModel: projectModel);
    return response;
  }

  @override
  Future<bool> isDublicatedProject({required String title}) async {
    final response = await _projectDataSource.findDublicates(title: title);
    for (int i = 0; i < response.model.length; i++) {
      if (response.model[i].title == title) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
