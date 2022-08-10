import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class UserProfileDataSource {
  Future downloadAvatar();
  // Future postUserProfile({
  //   required String avatarUrl,
  //   required String username,
  //   required String id,
  // });
  Future fetchCurrentUser({
    required String id,
    required String accessToken,
  });

  Future fetchUsersWhere({required String userName});
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final SecureStorageService _secureStorageService;
  UserProfileDataSourceImpl({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;
  final _network = NetworkSource().networkApiClient;

  final _userPath = '/users';
  final _userAvatarPath = '/users-avatar/';

  @override
  Future<BaseResponse<UserProfileModel>> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    try {
      final response = await _network.dio.get(
        '$_userPath/$id',
        options: _network.getRequestOptions(accessToken: accessToken),
      );

      final baseResponse = BaseResponse<UserProfileModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) => UserProfileModel.fromJson(json),
        response: response,
      );
      log('base response ${baseResponse.model}');
      return baseResponse;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchCurrentUser(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> downloadAvatar() async {
    try {
      final userId = await _secureStorageService.getUserData(
        type: StorageDataType.id,
      );

      final response = await _network.dio.get(
        '$_userAvatarPath$userId',
        options: await _network.getLocalRequestOptions(),
      );
      print('response ${response.data}');
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
