import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class ProjectUserData<T> {
  Future<T> fetchProject();
  Future<T> putData({
    required String color,
    required String title,
  });
}


class ProjectUserDataImpl implements ProjectUserData {
  final _projectsTable = SupabaseSource().dbClient.from('projects');

  @override
  Future<PostgrestResponse<dynamic>> putData({
    required String color,
    required String title,
  }) async {
    try {
      final _responce = await _projectsTable.insert({
        UserDataScheme.title: title,
        UserDataScheme.color: color,
        UserDataScheme.owner_id: SupabaseSource().dbClient.auth.currentUser!.id,
        UserDataScheme.created_at: DateTime.now().toString(),
      }).execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('putData error dataSource: $e');
    }
    return throw Exception('putData error dataSource ');
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchProject() async {
    try {
      final _responce = await _projectsTable
          .select('title, color')
          .eq('owner_id', SupabaseSource().dbClient.auth.currentUser!.id)
          .execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in fetchProject() dataSource:  $e');
    }
    return throw Exception('Error in fetchProject() dataSource: ');
  }
}
