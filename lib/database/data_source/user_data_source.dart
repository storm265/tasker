import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class UserProfileDataSource {
  Future<Response<dynamic>> downloadAvatar();
  Future<Response<dynamic>> postUserProfile({
    required String avatarUrl,
    required String username,
    required String id,
  });
  Future<Response<dynamic>> fetchCurrentUser({required String id});
  Future<Response<dynamic>> fetchUsersWhere({required String userName});
  Future<Response<dynamic>> updateAvatar({required String avatarUrl});
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final _network = NetworkSource().networkApiClient;
  final _path = '/users-avatar';
  final _userPath = '/users/';
  final _userAvatarPath = '/users-avatar/';
  final _storage = SecureStorageService();
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
          UserDataScheme.id: id,
          UserDataScheme.username: username,
          UserDataScheme.avatarUrl: avatarUrl,
          UserDataScheme.createdAt: DateTime.now().toString(),
        },
        options: _network.getRequestOptions(),
      );
      log('response data insertUserProfile : ${response.data}');
      log('response data insertUserProfile : ${response.statusCode}');
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl insertUserProfile(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> fetchCurrentUser({required String id}) async {
    try {
      final response = await _network.dio.get(
        _userPath,
        queryParameters: {UserDataScheme.id: id},
        options: _network.getRequestOptions(),
      );
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchCurrentUser(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> downloadAvatar() async {
    try {
      final response = await _network.dio.get(
        _userAvatarPath,
        queryParameters: {
          UserDataScheme.id: _storage.getUserData(type: StorageDataType.id)
        },
        options: _network.getRequestOptions(),
      );
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchAvatar(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> updateAvatar({required String avatarUrl}) async {
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
  Future<Response<dynamic>> fetchUsersWhere({required String userName}) async {
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
