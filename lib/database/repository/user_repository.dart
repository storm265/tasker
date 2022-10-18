import 'dart:io';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';

abstract class UserProfileRepository {
  Future<UserProfileModel> fetchCurrentUser({
    required String id,
    required String accessToken,
  });

  Future<StatsModel> fetchUserStatistics();

  Future<String> uploadAvatar({
    required String name,
    required File file,
  });
  Future<UserProfileModel> fetchUser({required String id});
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSourceImpl _userProfileDataSource;

  UserProfileRepositoryImpl(
      {required UserProfileDataSourceImpl userProfileDataSource})
      : _userProfileDataSource = userProfileDataSource;

  @override
  Future<UserProfileModel> fetchUser({required String id}) async {
    final response = await _userProfileDataSource.fetchUser(id: id);
    return UserProfileModel.fromJson(response);
  }

  @override
  Future<UserProfileModel> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    final response = await _userProfileDataSource.fetchCurrentUser(
      id: id,
      accessToken: accessToken,
    );

    return UserProfileModel.fromJson(response);
  }

  @override
  Future<StatsModel> fetchUserStatistics() async {
    final response = await _userProfileDataSource.fetchUserStatistics();
    return StatsModel.fromJson(response);
  }

  @override
  Future<String> uploadAvatar({
    required String name,
    required File file,
  }) async {
    final response = await _userProfileDataSource.uploadAvatar(
      name: name,
      file: file,
    );
    return response[AuthScheme.avatarUrl];
  }
}
