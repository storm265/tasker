import 'dart:developer';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';

abstract class UserProfileRepository {
  Future<BaseResponse<UserProfileModel>> fetchCurrentUser({
    required String id,
    required String accessToken,
  });
  Future fetchUserWhere({required String userName});
  Future<String> downloadAvatar();
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSourceImpl _userProfileDataSource;

  UserProfileRepositoryImpl(
      {required UserProfileDataSourceImpl userProfileDataSource})
      : _userProfileDataSource = userProfileDataSource;

  @override
  Future<BaseResponse<UserProfileModel>> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    final response = await _userProfileDataSource.fetchCurrentUser(
      id: id,
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<String> downloadAvatar() async {
    try {
      final response = await _userProfileDataSource.downloadAvatar();
      return response.data;
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
