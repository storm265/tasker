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
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final _network = NetworkSource().networkApiClient;

  final _userPath = '/users';
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
        _userAvatarPath,
        data: {
          UserDataScheme.id: id,
          UserDataScheme.username: username,
          UserDataScheme.avatarUrl: avatarUrl,
          UserDataScheme.createdAt: DateTime.now().toString(),
        },
        options: await _network.getRequestOptions(),
      );
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
      print('$_userPath/$id');
      final data = await _network.getRequestOptions();
      print('headers: ${data.headers}');
      final response = await _network.dio.get(
        'https://todolist.dev2.cogniteq.com/api/v1/users/f4d90fa5-1285-4cda-859d-973fbbfcd47e',
        
        // options: await _network.getRequestOptions(),
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJodHRwOi8vMC4wLjAuMDo4MDgwLyIsImlzcyI6Imh0dHA6Ly8wLjAuMC4wOjgwODAvIiwiZXhwIjoxNjU5MTkyNzUxLCJlbWFpbCI6ImNsb3duMjFAbWFpbC5ydSJ9.O7hVTkbTnv9Tgqs2L3YTdVJ4IPheDlNtomirJ1cVnM0',
          },
        ),
      );
      log(' data : ${response.data}');

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
        options: await _network.getRequestOptions(),
      );
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchAvatar(): $e');
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
