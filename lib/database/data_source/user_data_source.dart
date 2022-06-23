import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/services/error_service/error_service.dart';

import 'package:todo2/services/supabase/constants.dart';

abstract class UserDataSource {
  Future insert({
    required String email,
    required String password,
  });
}

class UserDataSourceImpl implements UserDataSource {
  final _table = 'user';
  final _supabase = SupabaseSource().restApiClient;
  @override
  Future<supabase.PostgrestResponse<dynamic>> insert({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.from(_table).insert({
        UserDataScheme.email: email,
        UserDataScheme.password: password,
        UserDataScheme.uuid: _supabase.auth.currentUser?.id,
        UserDataScheme.createdAt: DateTime.now().toString(),
      }).execute();
      return response;
    } catch (e) {
      ErrorService.printError('Error in insert() dataSource: $e');
      rethrow;
    }
  }
}
