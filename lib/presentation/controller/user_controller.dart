import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';

class UserController {
  final UserProfileRepositoryImpl _userProfileRepository;
  UserController({required UserProfileRepositoryImpl userProfileRepository})
      : _userProfileRepository = userProfileRepository;

  Future<UserProfileModel> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    try {
      final response = await _userProfileRepository.fetchCurrentUser(
        id: id,
        accessToken: accessToken,
      );

      return response;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<StatsModel> fetchUserStatistics() async {
    try {
      final response = await _userProfileRepository.fetchUserStatistics();
      return response;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
