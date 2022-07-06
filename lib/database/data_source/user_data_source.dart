import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/services/error_service/error_service.dart';

import 'package:todo2/services/supabase/constants.dart';

abstract class UserDataSource {
  Future fetchUser();
  // Future fetchUserId();
  Future insertUser({
    required String email,
    required String password,
  });
  Future fetchEmail();
}

class UserDataSourceImpl implements UserDataSource {
  final _table = 'user';
  final _supabase = SupabaseSource().restApiClient;
  @override
  Future<supabase.PostgrestResponse<dynamic>> insertUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.from(_table).insert({
        UserDataScheme.email: email,
        UserDataScheme.password: password,
        UserDataScheme.ownerId: _supabase.auth.currentUser?.id,
        UserDataScheme.createdAt: DateTime.now().toString(),
      }).execute();
      if (response.hasError) {
        log(response.error!.message);
      }
      return response;
    } catch (e) {
      ErrorService.printError('Error in insert() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<supabase.PostgrestResponse<dynamic>> fetchUser() async {
    try {
      final response = await _supabase
          .from(_table)
          .select('*')
          .eq(UserDataScheme.id, _supabase.auth.currentUser!.id)
          .execute();
      if (response.hasError) {
        log(response.error!.message);
      }
      return response;
    } catch (e) {
      ErrorService.printError('Error in fetchUser() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<supabase.PostgrestResponse<dynamic>> fetchEmail() async {
    try {
      final response =
          await _supabase.from(_table).select(UserDataScheme.email).execute();
      if (response.hasError) {
        log(response.error!.message);
      }
      return response;
    } catch (e) {
      ErrorService.printError('Error in fetchEmail() dataSource: $e');
      rethrow;
    }
  }

  // @override
  // Future<int> fetchUserId() async {
  //   try {
  //     final response = await _supabase
  //         .from(_table)
  //         .select(UserDataScheme.id)
  //         .eq(UserDataScheme.id, _supabase.auth.currentUser!.id)
  //         .execute();
  //     return response.data[0]['id'];
  //   } catch (e) {
  //     ErrorService.printError('Error in fetchAvatar() fetchUserId: $e');
  //     rethrow;
  //   }
  // }
}
