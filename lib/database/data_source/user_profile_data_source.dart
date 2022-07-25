import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class UserProfileDataSource {
  Future fetchAvatar();
  Future postUserProfile({
    required String avatarUrl,
    required String username,
    required String id,
  });
  Future fetchUsersWhere({required String userName});
  Future updateAvatar({required String avatarUrl});
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final _network = NetworkSource().networkApiClient;
  final _path = '/users-avatar';
  final _storageSource = SecureStorageSource().storageApi;
  @override
  Future<Response<dynamic>> postUserProfile({
    required String avatarUrl,
    required String username,
    required String id,
  }) async {
    try {
      final response = await _network.dio.post(
        _path,
        data: {
          UserProfileScheme.id: id,
          UserProfileScheme.username: username,
          UserProfileScheme.avatarPath: avatarUrl,
          UserProfileScheme.createdAt: DateTime.now().toString(),
        },
        options: Options(
          headers: {
            'Authorization':
                '${_network.tokenType} ${_storageSource.getAccessToken()}'
          },
        ),
      );
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl insertUserProfile(): $e');
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
      return Future.delayed(Duration(seconds: 1));
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
      return Future.delayed(Duration(seconds: 1));
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
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          ' Error in UserProfileDataSourceImpl fetchUsers():$e');
      rethrow;
    }
  }
}
