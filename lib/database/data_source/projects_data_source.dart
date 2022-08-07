import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/extensions/color_extension/color_string_extension.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

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
}

class ProjectUserDataImpl implements ProjectUserData {
  ProjectUserDataImpl({required SecureStorageService secureStorageService})
      : _secureStorageService = secureStorageService;

  final SecureStorageService _secureStorageService;
  final _projects = '/projects';
  final _projectsSearch = '/projects-search';
  final _network = NetworkSource().networkApiClient;

  @override
  Future<Response<dynamic>> createProject({
    required Color color,
    required String title,
  }) async {
    try {
      final response = await _network.dio.post(
        _projects,
        data: {
          ProjectDataScheme.ownerId:
              await _secureStorageService.getUserData(type: StorageDataType.id),
          ProjectDataScheme.color: '$color'.toStringColor(),
          ProjectDataScheme.title: title,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('createProject ${response.data}');
      return response;
    } catch (e) {
      ErrorService.printError('Error in ProjectUserDataImpl postProject(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> fetchOneProject() async {
    try {
      final response = await _network.dio.get(
        _projects,
        options: await _network.getLocalRequestOptions(),
      );
      log('fetchOneProject ${response.data}');
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchOneProject() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<BaseListResponse<ProjectModel>> fetchAllProjects() async {
    try {
      final response = await _network.dio.get(
        _projects,
        queryParameters: {
          AuthScheme.accessToken:
              await _secureStorageService.getUserData(type: StorageDataType.id)
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      // Response response =
      //     Response(requestOptions: RequestOptions(path: 'darkpath'), data: {
      //   "data": [
      //     {
      //       "id": "ce8f3cac-5c07-4e74-a286-017e39fdd9b3",
      //       "title": "Personal",
      //       "color": "#6074F9",
      //       "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //       "created_at": "2022-07-12T14:46:44.793558"
      //     },
      //     {
      //       "id": "eda45acd-22d1-4dc6-9f75-0c0e7b172d0f",
      //       "title": "Project 1",
      //       "color": "#FFFFD4",
      //       "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
      //       "created_at": "2022-07-13T08:43:24.147065"
      //     },
      //   ]
      // });      print('acces: $access');

      final baseResponse = BaseListResponse<ProjectModel>.fromJson(
        json: response.data[AuthScheme.data] ?? [],
        build: (List<Map<String, dynamic>> json) =>
            (response.data[AuthScheme.data] as List<Map<String, String>>)
                .map((e) => ProjectModel.fromJson(e))
                .toList(),
        response: response,
      );
      return baseResponse;
    } catch (e, t) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchAllProjects() dataSource:  $e, $t');
      rethrow;
    }
  }

  @override
  Future<BaseListResponse<ProjectModel>> findDublicates(
      {required String title}) async {
    try {
      final response = await _network.dio.get(
        _projectsSearch,
        queryParameters: {ProjectDataScheme.query: title},
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('find dublicates ${response.data}');
      final baseResponse = BaseListResponse<ProjectModel>.fromJson(
        json: response.data[AuthScheme.data],
        build: (List<Map<String, dynamic>> json) =>
            (response.data[AuthScheme.data] as List<Map<String, String>>)
                .map((e) => ProjectModel.fromJson(e))
                .toList(),
        response: response,
      );
      return baseResponse;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl findDublicates() dataSource:  $e');
      rethrow;
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
      ErrorService.printError('Error in dataSource fetchProjects() : $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> deleteProject(
      {required ProjectModel projectModel}) async {
    try {
      final Response response = await _network.dio.delete(
        _projects,
        queryParameters: {ProjectDataScheme.id: projectModel.ownerId},
        options: await _network.getLocalRequestOptions(),
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in dataSource deleteProject() : $e');
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ProjectModel>> updateProject({
    required Color color,
    required String title,
  }) async {
    try {
      final response = await _network.dio.put(
        _projects,
        data: {
          ProjectDataScheme.color: color.toString().toStringColor(),
          ProjectDataScheme.title: title,
          ProjectDataScheme.id:
              await _secureStorageService.getUserData(type: StorageDataType.id)
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );

      return BaseResponse<ProjectModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) => ProjectModel.fromJson(json),
        response: response,
      );
    } catch (e) {
      ErrorService.printError('Error in dataSource updateProject() : $e');
      rethrow;
    }
  }
}
