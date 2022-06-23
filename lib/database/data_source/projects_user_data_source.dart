
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class ProjectUserData {
  Future fetchProject();
  Future putData({
    required String color,
    required String title,
  });
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
        ProjectDataScheme.uuid: _supabase.auth.currentUser!.id,
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
}
