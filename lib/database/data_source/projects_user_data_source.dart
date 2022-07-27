import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class ProjectUserData {
  Future fetchProject();
  Future updateProject({
    required String color,
    required String title,
    required String oldTitle,
  });
  Future deleteProject({required ProjectModel projectModel});
  Future postProject({required String color, required String title});
  Future fetchProjectsWhere({required String title});
  Future fetchProjectId({required String project});
  Future findDublicates({required String title});
}

class ProjectUserDataImpl implements ProjectUserData {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final _path = '/projects';
  final _network = NetworkSource().networkApiClient;

  @override
  Future<Response<dynamic>> postProject({
    required String color,
    required String title,
  }) async {
    try {
      final response = await _network.dio.post(
        _path,
        data: {
          ProjectDataScheme.ownerId:
              await _secureStorageService.getUserData(type: StorageDataType.id),
          ProjectDataScheme.color: color,
          ProjectDataScheme.title: title,
          ProjectDataScheme.createdAt: DateTime.now().toIso8601String(),
        },
        options: _network.getRequestOptions(),
      );
      String? id =
          await _secureStorageService.getUserData(type: StorageDataType.id);
      log('id: $id');
      log('color: $color');
      log('title: $title');
      log('response: postProject ${response.data}');
      log('response: postProject ${response.statusCode}');
      return response;
    } catch (e) {
      ErrorService.printError('Error in ProjectUserDataImpl postProject(): $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchProject() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select()
      //     .eq(ProjectDataScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchProject() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> findDublicates(
      {required String title}) async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select()
      //     .eq(ProjectDataScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .eq(ProjectDataScheme.title, title)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl findDublicates() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchProjectId(
      {required String project}) async {
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
  Future<PostgrestResponse<dynamic>> fetchProjectsWhere(
      {required String title}) async {
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
  Future<PostgrestResponse<dynamic>> deleteProject(
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
  Future<PostgrestResponse> updateProject({
    required String color,
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
