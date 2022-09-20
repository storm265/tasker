import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/project_schemes/project_user_scheme.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

abstract class ProjectUserData {
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

  // Future<Map<String, dynamic>> fetchOneProject();

  Future<List<dynamic>> fetchAllProjects();

  Future<List<dynamic>> fetchProjectStats();
}

class ProjectUserDataImpl implements ProjectUserData {
  final SecureStorageSource _secureStorageService;
  final NetworkSource _network;

  ProjectUserDataImpl({
    required SecureStorageSource secureStorageService,
    required NetworkSource network,
  })  : _secureStorageService = secureStorageService,
        _network = network;

  final _userProjects = '/user-projects';
  final _projects = '/projects';
  final _projectsSearch = '/projects-search';
  final _projectsStats = '/projects-statistics';

  @override
  Future<Map<String, dynamic>> createProject({
    required Color color,
    required String title,
  }) async {
    try {
      final ownerId =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.post(
        path: _projects,
        data: {
          ProjectDataScheme.title: title,
          ProjectDataScheme.color: '$color'.toStringColor(),
          ProjectDataScheme.ownerId: ownerId,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data[ProjectDataScheme.data] as Map<String, dynamic>)
          : throw Failure(
              'Error: ${response.data[ProjectDataScheme.data][ProjectDataScheme.message]}');
    } catch (e) {
      throw Failure('Error: Create project error');
    }
  }

  @override
  Future<List<dynamic>> fetchAllProjects() async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.get(
        path: '$_userProjects/$id',
        options: await _network.getLocalRequestOptions(),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![ProjectDataScheme.data] as List<dynamic>)
          : throw Failure('Error: ${response.data![ProjectDataScheme.data]}');
    } catch (e) {
      throw Failure('Failure expersion $e');
    }
  }

  @override
  Future<List<dynamic>> searchProject({required String title}) async {
    try {
      // TODO FAKE
      // final response = await _network.get(
      //   path: '$_projectsSearch?query=$title',
      //   options: await _network.getLocalRequestOptions(useContentType: true),
      // );
      final response = await Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            "data": [
              {
                "id": "eda45acd-22d1-4dc6-9f75-0c0e7b172d0f",
                "title": "Project 1",
                "color": "#FFFFD4",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "created_at": "2022-07-13T08:43:24.147065"
              },
              {
                "id": "85732d06-0d93-4be9-b1ec-30defc76fad0",
                "title": "Project 2",
                "color": "#FFFFD4",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "created_at": "2022-07-13T08:43:43.903710"
              },
              {
                "id": "2fe0fa38-9dec-4e1f-a259-161dde928258",
                "title": "Project 3",
                "color": "#FFFFD4",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "created_at": "2022-07-13T08:43:46.231289"
              },
              {
                "id": "28ce0b43-78d5-4fc6-bd4f-9bea47d4b2d0",
                "title": "Project 4",
                "color": "#FFFFD4",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "created_at": "2022-07-13T08:43:48.699244"
              }
            ]
          },
          statusCode: 200);
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![ProjectDataScheme.data] as List<dynamic>)
          : throw Failure('Error: get project error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteProject({required ProjectModel projectModel}) async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);

      final Response response = await _network.delete(
        path: '$_projects/$id',
        queryParameters: {ProjectDataScheme.id: projectModel.id},
        options: await _network.getLocalRequestOptions(),
      );
      if (!NetworkErrorService.isSuccessful(response)) {
        throw Failure(
            'Error: ${response.data[ProjectDataScheme.data][AuthScheme.message]}');
      }
    } catch (e) {
      log('delete project error :$e');
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> updateProject({
    required ProjectModel projectModel,
    required Color color,
    required String title,
  }) async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.put(
        path: '$_projects/${projectModel.id}',
        data: {
          ProjectDataScheme.color: color.toString().toStringColor(),
          ProjectDataScheme.title: title,
          ProjectDataScheme.ownerId: id,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data[ProjectDataScheme.data] as Map<String, dynamic>)
          : throw Failure(
              'Error: ${response.data[ProjectDataScheme.data][ProjectDataScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchProjectStats() async {
    try {
      final userId =
          await _secureStorageService.getUserData(type: StorageDataType.id);

      final response = await _network.get(
        path: '$_projectsStats/$userId',
        options: await _network.getLocalRequestOptions(),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![ProjectDataScheme.data] as List<dynamic>)
          : throw Failure('Error: Get Statistics');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  // @override
  // Future<Map<String, dynamic>> fetchOneProject() async {
  //   try {
  //     final id =
  //         await _secureStorageService.getUserData(type: StorageDataType.id);
  //     final response = await _network.dio.get(
  //       '$_projects/$id',
  //       options: await _network.getLocalRequestOptions(),
  //     );
  //     return NetworkErrorService.isSuccessful(response)
  //         ? (response.data[ProjectDataScheme.data] as Map<String, dynamic>)
  //         : throw Failure(
  //             'Error: ${response.data[ProjectDataScheme.data][ProjectDataScheme.message]}');
  //   } catch (e) {
  //     debugPrint('fetchOneProject datasource  $e');
  //     throw Failure(e.toString());
  //   }
  // }
}
