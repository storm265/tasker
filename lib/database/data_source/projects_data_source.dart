import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/extensions/color_extension/color_string_extension.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class ProjectUserData {
  Future updateProject({
    required Color color,
    required String title,
    required String oldTitle,
  });
  Future deleteProject({required ProjectModel projectModel});
  Future createProject({required Color color, required String title});
  Future fetchProjectsWhere({required String title});
  Future fetchProjectId({required String project});
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
  Future<Response<dynamic>> fetchAllProjects() async {
    try {
      final response = await _network.dio.get(
        _projects,
        queryParameters: {
          AuthScheme.accessToken:
              await _secureStorageService.getUserData(type: StorageDataType.id)
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('fetchAllProjects${response.data}');
            final baseResponse = BaseResponse<AuthModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) => AuthModel.fromJson(json),
        response: response,
      );
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchAllProjects() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> findDublicates({required String title}) async {
    try {
      final response = await _network.dio.get(
        _projectsSearch,
        queryParameters: {ProjectDataScheme.query: title},
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('find dublicates ${response.data}');
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl findDublicates() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> fetchProjectId({required String project}) async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(ProjectDataScheme.id)
      //     .eq(ProjectDataScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .eq(ProjectDataScheme.title, project)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchProjectId() dataSource:  $e');
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
      // final response = await _supabase
      //     .from(_table)
      //     .delete()
      //     .eq(ProjectDataScheme.ownerId, projectModel.ownerId)
      //     .eq(ProjectDataScheme.title, projectModel.title)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError('Error in dataSource deleteProject() : $e');
      rethrow;
    }
  }

  @override
  Future<Response> updateProject({
    required Color color,
    required String title,
    required String oldTitle,
  }) async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .update({
      //       ProjectDataScheme.title: title,
      //       ProjectDataScheme.createdAt: DateTime.now().toString(),
      //       ProjectDataScheme.color: color,
      //     })
      //     .eq(ProjectDataScheme.title, oldTitle)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError('Error in dataSource updateProject() : $e');
      rethrow;
    }
  }
}
