import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/project_schemes/project_user_scheme.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/error_service/network_error_service.dart';
import 'package:todo2/services/extensions/color_extension/color_string_extension.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

// TODO generic
abstract class ProjectUserData {
  Future updateProject({
    required Color color,
    required String title,
  });
  Future deleteProject({required ProjectModel projectModel});
  Future createProject({required Color color, required String title});
  Future fetchProjectsWhere({required String title});

  Future findDublicates({required String title});
  Future fetchOneProject();
  Future fetchAllProjects();

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
      await _network.networkApiClient.dio.post(
        _projects,
        data: {
          ProjectDataScheme.ownerId:
              await _secureStorageService.getUserData(type: StorageDataType.id),
          ProjectDataScheme.color: '$color'.toStringColor(),
          ProjectDataScheme.title: title,
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> fetchOneProject() async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.get(
        '$_projects/$id',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data[AuthScheme.data] as Map<String, dynamic>)
          : throw Failure(
              'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
    } catch (e) {
      debugPrint('fetchOneProject datasource  $e');
      throw Failure(e.toString());
    }
  }

// works
  @override
  Future<List<dynamic>> fetchAllProjects() async {
    try {
      // final id =
      //     await _secureStorageService.getUserData(type: StorageDataType.id);
      // final response = await _network.networkApiClient.dio.get(
      //   '$_projects/$id',
      //   options: await _network.networkApiClient.getLocalRequestOptions(),
      // );
// fake api

      final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            "data": [
              {
                "id": "ce8f3cac-5c07-4e74-a286-017e39fdd9b3",
                "title": "Personal",
                "color": "#6074F9",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "created_at": "2022-07-12T14:46:44.793558"
              },
              {
                "id": "eda45acd-22d1-4dc6-9f75-0c0e7b172d0f",
                "title": "Project 1",
                "color": "#FFFFD4",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "created_at": "2022-07-13T08:43:24.147065"
              },
              {
                "id": "85732d06-0d93-4be9-b1ec-30defc76fad0",
                "title": "Project 2sdgfhsuhiisuhfreisfhusifhshiufhus",
                "color": "#FFFFD4",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "created_at": "2022-07-13T08:43:43.903710"
              },
            ]
          });
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![AuthScheme.data] as List<dynamic>)
          : throw Failure('Error: get project error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> findDublicates({required String title}) async {
    try {
      final response = await _network.networkApiClient.dio.get(
        _projectsSearch,
        queryParameters: {ProjectDataScheme.query: title},
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
      log('find dublicates ${response.data}');

      // BaseListResponse<ProjectModel> empty =
      //     BaseListResponse<ProjectModel>(model: []);

      // if ((response.data[AuthScheme.data] as List<dynamic>).isEmpty) {
      //   return empty;
      // } else {
      //   final baseResponse = BaseListResponse<ProjectModel>.fromJson(
      //     json: response.data[AuthScheme.data],
      //     build: (List<Map<String, dynamic>> json) =>
      //         (response.data[AuthScheme.data] as List<Map<String, String>>)
      //             .map((e) => ProjectModel.fromJson(e))
      //             .toList(),
      //     response: response,
      //   );
      //   return baseResponse;
      // }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> fetchProjectsWhere({required String title}) async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select()
      //     .ilike(
      //       ProjectDataScheme.title,
      //       '%$title%',
      //     )
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
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
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateProject({
    required Color color,
    required String title,
  }) async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.put(
        '$_projects/$id',
        data: {
          ProjectDataScheme.color: color.toString().toStringColor(),
          ProjectDataScheme.title: title,
          ProjectDataScheme.id: id
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
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
