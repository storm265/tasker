import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/project_schemes/project_user_scheme.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/extensions/color_extension/color_string_extension.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';


abstract class ProjectUserData {
  Future<void> updateProject({
     required ProjectModel projectModel,
    required Color color,
    required String title,
  });
  Future<void> deleteProject({required ProjectModel projectModel});
  Future<void> createProject({required Color color, required String title});
  Future searchProject({required String title});

  // Future<Map<String, dynamic>> fetchOneProject();
  Future<List<dynamic>> fetchAllProjects();

  Future<List<dynamic>> fetchProjectStats();
}

class ProjectUserDataImpl implements ProjectUserData {
  final SecureStorageService _secureStorageService;
  final NetworkSource _network;

  ProjectUserDataImpl({
    required SecureStorageService secureStorageService,
    required NetworkSource network,
  })  : _secureStorageService = secureStorageService,
        _network = network;

  final _projects = '/projects';
  final _projectsSearch = '/projects-search';
  final _projectsStats = '/projects-statistics';

  @override
  Future<void> createProject({
    required Color color,
    required String title,
  }) async {
    try {
      log('title : $title');
      log('title : ${await _secureStorageService.getUserData(type: StorageDataType.id)}');
      log('title : $color');
      final response = await _network.networkApiClient.dio.post(
        _projects,
        data: {
          ProjectDataScheme.title: title,
          ProjectDataScheme.ownerId:
              await _secureStorageService.getUserData(type: StorageDataType.id),
          ProjectDataScheme.color: '$color'.toStringColor(),
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
      log('response ${response.data}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  // @override
  // Future<Map<String, dynamic>> fetchOneProject() async {
  //   try {
  //     final id =
  //         await _secureStorageService.getUserData(type: StorageDataType.id);
  //     final response = await _network.networkApiClient.dio.get(
  //       '$_projects/$id',
  //       options: await _network.networkApiClient.getLocalRequestOptions(),
  //     );
  //     return NetworkErrorService.isSuccessful(response)
  //         ? (response.data[AuthScheme.data] as Map<String, dynamic>)
  //         : throw Failure(
  //             'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
  //   } catch (e) {
  //     debugPrint('fetchOneProject datasource  $e');
  //     throw Failure(e.toString());
  //   }
  // }

// works
  @override
  Future<List<dynamic>> fetchAllProjects() async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.get(
        '$_projects/$id',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
// fake api

      // final response = Response(
      //     requestOptions: RequestOptions(path: ''),
      //     statusCode: 200,
      //     data: {
      //       "data": [
      //         {
      //           "id": "ce8f3cac-5c07-4e74-a286-017e39fdd9b3",
      //           "title": "Personal",
      //           "color": "#6074F9",
      //           "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //           "created_at": "2022-07-12T14:46:44.793558"
      //         },
      //         {
      //           "id": "eda45acd-22d1-4dc6-9f75-0c0e7b172d0f",
      //           "title": "Project 1",
      //           "color": "#6074F9",
      //           "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //           "created_at": "2022-07-13T08:43:24.147065"
      //         },
      //         {
      //           "id": "85732d06-0d93-4be9-b1ec-30defc76fad0",
      //           "title": "Project 2sdgfhsuhiisuhfreisfhusifhshiufhus",
      //           "color": "#6074F9",
      //           "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //           "created_at": "2022-07-13T08:43:43.903710"
      //         },
      //         {
      //           "id": "85732d06-0d93-4be9-b1ec-30defc76fad0",
      //           "title": "Project 2sdgfhsuhiisuhfreisfhusifhshiufhus",
      //           "color": "#6074F9",
      //           "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //           "created_at": "2022-07-13T08:43:43.903710"
      //         },
      //         {
      //           "id": "85732d06-0d93-4be9-b1ec-30defc76fad0",
      //           "title": "Project 2sdgfhsuhiisuhfreisfhusifhshiufhus",
      //           "color": "#6074F9",
      //           "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //           "created_at": "2022-07-13T08:43:43.903710"
      //         },
      //         {
      //           "id": "85732d06-0d93-4be9-b1ec-30defc76fad0",
      //           "title": "Project 2sdgfhsuhiisuhfreisfhusifhshiufhus",
      //           "color": "#6074F9",
      //           "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //           "created_at": "2022-07-13T08:43:43.903710"
      //         },
      //       ]
      //     });
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![AuthScheme.data] as List<dynamic>)
          : throw Failure('Error: get project error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> searchProject({required String title}) async {
    try {
      final response = await _network.networkApiClient.dio.get(
        '$_projectsSearch?query=$title',
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![AuthScheme.data] as List<dynamic>)
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

      final Response response = await _network.networkApiClient.dio.delete(
        '$_projects/$id',
        queryParameters: {ProjectDataScheme.id: projectModel.id},
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
      if (!NetworkErrorService.isSuccessful(response)) {
        throw Failure(
            'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
      }
    } catch (e) {
      log('delete project error :$e');
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateProject({
    required ProjectModel projectModel,
    required Color color,
    required String title,
  }) async {
    try {
      log('update project data: $title');
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.put(
        '$_projects/${projectModel.id}',
        data: {
          ProjectDataScheme.color:
             color.toString().toStringColor(),
          ProjectDataScheme.title: title,
          ProjectDataScheme.ownerId: id,
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
      log('updating project: ${response.data[AuthScheme.data]}');
      if (!NetworkErrorService.isSuccessful(response)) {
        throw Failure(
            'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchProjectStats() async {
    try {
      // final userId =
      //     await _secureStorageService.getUserData(type: StorageDataType.id);

      // final response = await _network.networkApiClient.dio.get(
      //   '$_projectsStats/$userId',
      //   options: await _network.networkApiClient.getLocalRequestOptions(),
      // );
      final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            "data": [
              {
                "project_id": "ce8f3cac-5c07-4e74-a286-017e39fdd9b3",
                "tasks_number": 0
              },
              {
                "project_id": "eda45acd-22d1-4dc6-9f75-0c0e7b172d0f",
                "tasks_number": 0
              },
              {
                "project_id": "85732d06-0d93-4be9-b1ec-30defc76fad0",
                "tasks_number": 0
              },
              {
                "project_id": "2fe0fa38-9dec-4e1f-a259-161dde928258",
                "tasks_number": 0
              },
              {
                "project_id": "28ce0b43-78d5-4fc6-bd4f-9bea47d4b2d0",
                "tasks_number": 0
              }
            ]
          });

      return NetworkErrorService.isSuccessful(response)
          ? (response.data![AuthScheme.data] as List<dynamic>)
          : throw Failure('Error: dd');
      // return NetworkErrorService.isSuccessful(response)
      //     ? (response.data[AuthScheme.data] as List<dynamic>)
      //     : throw Failure(
      //         'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
