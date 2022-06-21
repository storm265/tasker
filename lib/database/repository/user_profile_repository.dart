import 'package:todo2/database/data_source/user_profile_data_source.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class UserProfileRepository {
  Future<String> fetchUserName();
  Future<String> fetchAvatar();
  Future<void> insertImg({
    required String avatarUrl,
    required String username,
  });
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final _userProfileDataSource = UserProfileDataSourceImpl();
  final _table = 'avatar';
  final _supabase = SupabaseSource().restApiClient;
  @override
  Future<void> insertImg({
    required String avatarUrl,
    required String username,
  }) async {
    try {
      await _userProfileDataSource.insertImg(
        avatarUrl: avatarUrl,
        username: username,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> fetchUserName() async {
    try {
      final response = await _userProfileDataSource.fetchUserName();
      return response.data[0]['username'] as String;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> fetchAvatar() async {
    try {
      final response = await _userProfileDataSource.fetchAvatar();
      final imageResponce = _supabase.storage
          .from(_table)
          .getPublicUrl(response.data[0]['avatar_url']);
      final image = imageResponce.data;
      return image!;
    } catch (e) {
      rethrow;
    }
  }
}
