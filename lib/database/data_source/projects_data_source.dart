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
  Future<void> createProject({
    required Color color,
    required String title,
  });
  Future<List<dynamic>> searchProject({required String title});

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

  final _userProjects = '/user-projects';
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
          ProjectDataScheme.title: title,
          ProjectDataScheme.color: '$color'.toStringColor(),
          ProjectDataScheme.ownerId:
              await _secureStorageService.getUserData(type: StorageDataType.id),
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
    } catch (e) {
      throw Failure('Error: Create project error');
    }
  }

  @override
  Future<List<dynamic>> fetchAllProjects() async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.get(
        '$_userProjects/$id',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![AuthScheme.data] as List<dynamic>)
          : throw Failure('Error: Get project error');
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
          ProjectDataScheme.color: color.toString().toStringColor(),
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
      final userId =
          await _secureStorageService.getUserData(type: StorageDataType.id);

      final response = await _network.networkApiClient.dio.get(
        '$_projectsStats/$userId',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![AuthScheme.data] as List<dynamic>)
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
}
