import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
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
        UserDataScheme.title: title,
        UserDataScheme.color: color,
        UserDataScheme.ownerId: _supabase.auth.currentUser!.id,
        UserDataScheme.createdAt: DateTime.now().toString(),
      }).execute();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchProject() async {
    try {
      final response = await _supabase
          .from(_table)
          .select('${UserDataScheme.title}, ${UserDataScheme.color}')
          .eq(UserDataScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
