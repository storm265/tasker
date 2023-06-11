import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/data/data_source/project/project_data_source.dart';

import 'package:todo2/domain/model/project_models/projects_model.dart';
import 'package:todo2/schemas/database_scheme/auth_scheme.dart';
import 'package:todo2/schemas/database_scheme/project_schemes/project_user_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/secure_storage_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class ProjectUserDataSourceImpl implements ProjectUserDataSource {
  final SecureStorageSource _secureStorageService;
  final NetworkSource _network;

  ProjectUserDataSourceImpl({
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
  }

  @override
  Future<List<dynamic>> fetchAllProjects() async {
    final id =
        await _secureStorageService.getUserData(type: StorageDataType.id);
    final response = await _network.get(
      path: '$_userProjects/$id',
      options: await _network.getLocalRequestOptions(),
    );
    return NetworkErrorService.isSuccessful(response)
        ? (response.data![ProjectDataScheme.data] as List<dynamic>)
        : throw Failure('Error: ${response.data![ProjectDataScheme.data]}');
  }

  @override
  Future<List<dynamic>> searchProject({required String title}) async {
    final response = await _network.get(
      path: '$_projectsSearch?query=$title',
      options: await _network.getLocalRequestOptions(useContentType: true),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data![ProjectDataScheme.data] as List<dynamic>)
        : throw Failure('Error: get project error');
  }

  @override
  Future<void> deleteProject({required ProjectModel projectModel}) async {
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
  }

  @override
  Future<Map<String, dynamic>> updateProject({
    required ProjectModel projectModel,
    required Color color,
    required String title,
  }) async {
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
  }

  @override
  Future<List<dynamic>> fetchProjectStats() async {
    final userId =
        await _secureStorageService.getUserData(type: StorageDataType.id);

    final response = await _network.get(
      path: '$_projectsStats/$userId',
      options: await _network.getLocalRequestOptions(),
    );
    return NetworkErrorService.isSuccessful(response)
        ? (response.data![ProjectDataScheme.data] as List<dynamic>)
        : throw Failure('Error: Get Statistics');
  }

  @override
  Future<Map<String, dynamic>> fetchOneProject(
      {required String projectId}) async {
    final response = await _network.get(
      path: '$_projects/$projectId',
      options: await _network.getLocalRequestOptions(),
    );
    return NetworkErrorService.isSuccessful(response)
        ? (response.data[ProjectDataScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[ProjectDataScheme.data][ProjectDataScheme.message]}');
  }
}
