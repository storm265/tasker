import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
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
}

class ProjectUserDataImpl implements ProjectUserData {
  final SecureStorageService _secureStorageService;
  final NetworkSource _network;
  ProjectUserDataImpl(
      {required SecureStorageService secureStorageService,
      required NetworkSource network})
      : _secureStorageService = secureStorageService,
        _network = network;

  final _projects = '/projects';
  final _projectsSearch = '/projects-search';

  @override
  Future<void> createProject({
    required Color color,
    required String title,
  }) async {
    try {
      final response = await _network.networkApiClient.dio.post(
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
      log('createProject ${response.data}');
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
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.get(
        '$_projects/$id',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );

      return NetworkErrorService.isSuccessful(response)
          ? (response.data![AuthScheme.data] as List<dynamic>)
          : throw Failure('Error: get project error');
    } catch (e) {
      debugPrint('fetchAllProjects datasource  $e');
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
}
