import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class ProjectUserData {
  // Future getId();
  Future fetchMyProjects();
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
      // int projectId = await getId();
      final response = await _supabase.from(_table).insert({
        ProjectDataScheme.title: title,
        ProjectDataScheme.color: color,
        ProjectDataScheme.uuid: _supabase.auth.currentUser!.id,
        // ProjectDataScheme.uuid:projectId + 1,
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
  Future<PostgrestResponse<dynamic>> fetchMyProjects() async {
    try {
      final response = await _supabase
          .from(_table)
          .select('*')
          .eq(ProjectDataScheme.uuid, _supabase.auth.currentUser!.id)
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
          .select('*')
          .eq(ProjectDataScheme.uuid, _supabase.auth.currentUser!.id)
          .eq(ProjectDataScheme.title, project)
          .execute();
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchProject() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchProjectsWhere(
      {required String title}) async {
    try {
      final response = await _supabase
          .from(_table)
          .select('*')
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
}
