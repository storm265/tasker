import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';

import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class ProjectUserData {
  Future fetchProject();
  Future updateProject({required ProjectModel projectModel});
  Future deleteProject({required int id});

  Future putData({
    required String color,
    required String title,
  });
  Future fetchProjectsWhere({required String title});
  Future fetchProjectId({required String project});
}

class ProjectUserDataImpl implements ProjectUserData {
  final _table = 'projects';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<PostgrestResponse<dynamic>> putData({
    required String color,
    required String title,
  }) async {
    try {
      final response = await _supabase.from(_table).insert({
        ProjectDataScheme.title: title,
        ProjectDataScheme.color: color,
        ProjectDataScheme.ownerId: _supabase.auth.currentUser!.id,
        ProjectDataScheme.createdAt: DateTime.now().toString(),
      }).execute();

      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl putData() error dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchProject() async {
    try {
      final response = await _supabase
          .from(_table)
          .select()
          .eq(ProjectDataScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchProject() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchProjectId(
      {required String project}) async {
    try {
      final response = await _supabase
          .from(_table)
          .select(ProjectDataScheme.id)
          .eq(ProjectDataScheme.ownerId, _supabase.auth.currentUser!.id)
          .eq(ProjectDataScheme.title, project)
          .execute();
      return response;
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
      final response = await _supabase
          .from(_table)
          .select()
          .ilike(
            ProjectDataScheme.title,
            '%$title%',
          )
          .execute();
      return response;
    } catch (e) {
      ErrorService.printError('Error in dataSource fetchProjects() : $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> deleteProject({required int id}) async {
    try {
      final response = await _supabase
          .from(_table)
          .delete()
          .eq(ProjectDataScheme.id, id)
          .execute();
      return response;
    } catch (e) {
      ErrorService.printError('Error in dataSource deleteProject() : $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse> updateProject(
      {required ProjectModel projectModel}) async {
    try {
      final response = await _supabase.from(_table).update({
        ProjectDataScheme.title: projectModel.title,
        ProjectDataScheme.createdAt: DateTime.now().toString(),
        ProjectDataScheme.color: projectModel.color,
      }).execute();

      return response;
    } catch (e) {
      ErrorService.printError('Error in dataSource updateProject() : $e');
      rethrow;
    }
  }
}
