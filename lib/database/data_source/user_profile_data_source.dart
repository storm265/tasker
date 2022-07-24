import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';

abstract class UserProfileDataSource {
  Future fetchUserId();
  Future fetchUserName();
  Future fetchAvatar();
  Future postUserProfile({
    required String avatarUrl,
    required String username,
  });
  Future fetchUsersWhere({required String userName});
  Future updateAvatar({required String avatarUrl});
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final _supabase = NetworkSource().networkApiClient;
  final _table = 'user_profile';

  @override
  Future<int> fetchUserId() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(UserProfileScheme.id)
      //     .eq(UserProfileScheme.uuid, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response.data[0][UserProfileScheme.id];
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchUserId(): $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> postUserProfile({
    required String avatarUrl,
    required String username,
  }) async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   UserProfileScheme.username: username,
      //   UserProfileScheme.avatarUrl: avatarUrl,
      //   UserProfileScheme.uuid: _supabase.auth.currentUser!.id,
      //   UserProfileScheme.createdAt: DateTime.now().toString(),
      // }).execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl insertUserProfile(): $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchUserName() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(UserProfileScheme.username)
      //     .eq(UserProfileScheme.uuid, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchUserName(): $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> updateAvatar(
      {required String avatarUrl}) async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .update({UserProfileScheme.avatarUrl: avatarUrl})
      //     .eq(UserProfileScheme.uuid, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl updateAvatar(): $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchAvatar() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(UserProfileScheme.avatarUrl)
      //     .eq(UserProfileScheme.uuid, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchAvatar(): $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchUsersWhere(
      {required String userName}) async {
    try {
      // final response = await NetworkSource()
      //     .networkApiClient
      //     .from(_table)
      //     .select()
      //     .ilike(
      //       UserProfileScheme.username,
      //       '%$userName%',
      //     )
      //     .execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          ' Error in UserProfileDataSourceImpl fetchUsers():$e');
      rethrow;
    }
  }
}
