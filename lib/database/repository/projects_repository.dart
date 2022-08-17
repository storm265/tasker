import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
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
    network: NetworkSource(),
    secureStorageService: SecureStorageService(),
  );

  @override
  Future<ProjectModel> fetchOneProject() async {
    final response = await _projectDataSource.fetchOneProject();
    //  return response.data[ProjectDataScheme.data];
    return ProjectModel(
      id: '',
      color: Colors.red,
      createdAt: DateTime.now(),
      ownerId: '',
      title: '',
    );
  }

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
  Future<void> createProject({
    required Color color,
    required String title,
  }) async {
    try {
      await _projectDataSource.createProject(
        color: color,
        title: title,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjectsWhere({required String title}) async {
    final response = await _projectDataSource.fetchProjectsWhere(title: title);
    return (response.data as List<dynamic>)
        .map((json) => ProjectModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> updateProject({
    required Color color,
    required String title,
  }) async {
    try {
      await _projectDataSource.updateProject(
        color: color,
        title: title,
      );
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

  @override
  Future<bool> isDublicatedProject({required String title}) async {
    final response = await _projectDataSource.findDublicates(title: title);
    // for (int i = 0; i < response.model.length; i++) {
    //   if (response.model[i].title == title) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }
    return false;
  }
}
