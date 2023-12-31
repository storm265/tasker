import 'dart:io';
import 'package:todo2/data/data_source/user/user_data_source_impl.dart';
import 'package:todo2/domain/model/profile_models/stats_model.dart';
import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/domain/repository/user_repository.dart';
import 'package:todo2/schemas/database_scheme/auth_scheme.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  UserProfileRepositoryImpl(
      {required UserProfileDataSourceImpl userProfileDataSource})
      : _userProfileDataSource = userProfileDataSource;

  final UserProfileDataSourceImpl _userProfileDataSource;

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
