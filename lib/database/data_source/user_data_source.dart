import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/services/error_service/error_service.dart';

import 'package:todo2/services/supabase/constants.dart';

abstract class UserDataSource {
  Future fetchUser();
  Future postUser({
    required String email,
    required String password,
  });
  Future fetchEmail();
}

class UserDataSourceImpl implements UserDataSource {
  final _table = 'user';
  final _supabase = NetworkSource().networkApiClient;

  @override
  Future<supabase.PostgrestResponse<dynamic>> postUser({
    required String email,
    required String password,
  }) async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   UserDataScheme.email: email,
      //   UserDataScheme.password: password,
      //   UserDataScheme.ownerId: _supabase.auth.currentUser?.id,
      //   UserDataScheme.createdAt: DateTime.now().toString(),
      // }).execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError('Error in UserDataSourceImpl insert(): $e');
      rethrow;
    }
  }

  @override
  Future<supabase.PostgrestResponse<dynamic>> fetchUser() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select()
      //     .eq(UserDataScheme.id, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError('Error in UserDataSourceImpl fetchUser() : $e');
      rethrow;
    }
  }

  @override
  Future<supabase.PostgrestResponse<dynamic>> fetchEmail() async {
    try {
      // final response =
      //     await _supabase.from(_table).select(UserDataScheme.email).execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError('Error in UserDataSourceImpl fetchEmail(): $e');
      rethrow;
    }
  }
}
