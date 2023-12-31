import 'package:todo2/domain/model/profile_models/stats_model.dart';
import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/domain/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';

class UserProvider {
  UserProvider({required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository;

  final UserProfileRepository _userProfileRepository;

  StatsModel stats = StatsModel(
    createdTasks: 0,
    completedTasks: 0,
    events: '1%',
    quickNotes: '1%',
    todo: '1%',
  );

  Future<void> fetchStats() async {
    stats = await fetchUserStatistics();
  }

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
