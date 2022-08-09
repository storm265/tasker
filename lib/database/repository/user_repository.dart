import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class UserProfileRepository {
  // Future postProfile({
  //   required String avatarUrl,
  //   required String username,
  //   required String id,
  // });
  Future fetchCurrentUser();
  Future fetchUserWhere({required String userName});
  Future downloadAvatar();
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final _userProfileDataSource =
      UserProfileDataSourceImpl(secureStorageService: SecureStorageService());

  // @override
  // Future<Response<dynamic>> postProfile({
  //   required String avatarUrl,
  //   required String username,
  //   required String id,
  // }) async {
  //   final response = await _userProfileDataSource.postUserProfile(
  //     id: id,
  //     avatarUrl: avatarUrl,
  //     username: username,
  //   );
  //   return response;
  // }

  @override
  Future<BaseResponse<UserProfileModel>> fetchCurrentUser() async {
    final response = await _userProfileDataSource.fetchCurrentUser();

    return response;
  }

  @override
  Future<String> downloadAvatar() async {
    try {
      final response = await _userProfileDataSource.downloadAvatar();
      final image = await response.data[0][UserDataScheme.avatarUrl];
      log(' fetchAvatar repo: $image');
      return response.data[''];
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileRepositoryImpl fetchAvatar() : $e');
      rethrow;
    }
  }

  @override
  Future<List<UserProfileModel>> fetchUserWhere(
      {required String userName}) async {
    try {
      final response =
          await _userProfileDataSource.fetchUsersWhere(userName: userName);
      return (response.data as List<dynamic>)
          .map((json) => UserProfileModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileRepositoryImpl fetchUsersWhere(): $e');
      rethrow;
    }
  }
}
