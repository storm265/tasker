import 'dart:io';

import 'package:todo2/domain/model/profile_models/stats_model.dart';
import 'package:todo2/domain/model/profile_models/users_profile_model.dart';

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
