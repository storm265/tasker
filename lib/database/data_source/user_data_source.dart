
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';


abstract class UserDataSource<T> {
  Future<T> insert({
    required String email,
    required String password,
  });
}

class UserDataSourceImpl implements UserDataSource {
  final _supabase = SupabaseSource().dbClient.from('users');
  @override
  Future<supabase.PostgrestResponse<dynamic>> insert({
    required String email,
    required String password,
  }) async {
    try {
      final _responce = await _supabase.insert({
        UserDataScheme.uid: SupabaseSource().dbClient.auth.currentUser?.id,
        UserDataScheme.email: email,
        UserDataScheme.password: password,
        UserDataScheme.created_at: DateTime.now().toString(),
      }).execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in insert() dataSource: $e');
    }
    return throw Exception('Error in insert() dataSource');
  }
}
