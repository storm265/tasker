import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class UserProfileRepository {
  Future<UserProfileModel> fetchCurrentUser({
    required String id,
    required String accessToken,
  });
  Future<String> downloadAvatar();
  Future<StatsModel> fetchUserStatistics();
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSourceImpl _userProfileDataSource;

  UserProfileRepositoryImpl(
      {required UserProfileDataSourceImpl userProfileDataSource})
      : _userProfileDataSource = userProfileDataSource;

  @override
  Future<UserProfileModel> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    try {
      final response = await _userProfileDataSource.fetchCurrentUser(
        id: id,
        accessToken: accessToken,
      );

      return UserProfileModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> downloadAvatar() async {
    try {
      final response = await _userProfileDataSource.downloadAvatar();
      return response.data;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<StatsModel> fetchUserStatistics() async {
    try {
      final response = await _userProfileDataSource.fetchUserStatistics();
      return StatsModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
