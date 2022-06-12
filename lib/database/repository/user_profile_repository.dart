import 'package:todo2/database/data_source/user_profile_data_source.dart';
import 'package:todo2/model/supabase/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class UserProfileRepository<T> {
  Future<String> fetchUserName();
  Future<String> fetchAvatar();
  Future<void> insertImg({
    required String avatarUrl,
    required String username,
  });
}

class UserProfileRepositoryImpl implements UserProfileRepository<UsersProfile> {
  final _userProfileDataSource = UserProfileDataSourceImpl();
  final _supabase = SupabaseSource().dbClient.storage.from('avatar');
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
      ErrorService.printError(
          'Error in insertImg() UserProfileRepositoryImpl: $e');
    }
  }

  @override
  Future<String> fetchUserName() async {
    try {
      final _responce = await _userProfileDataSource.fetchUserName();

      return _responce.data[0]['username'] as String;
    } catch (e) {
      ErrorService.printError(
          'Error in fetchUserName() UserProfileRepositoryImpl: $e');
    }
    throw Exception('Error in fetchUserName() UserProfileRepositoryImpl');
  }

  @override
  Future<String> fetchAvatar() async {
    try {
      final _responce = await _userProfileDataSource.fetchAvatar();
      if (!_responce.hasError) {
        final _rez = _supabase.getPublicUrl(_responce.data[0]['avatar_url']);
        final _image = _rez.data;
        return _image!;
      }
    } catch (e) {
      ErrorService.printError(
          'Error in fetchAvatar() UserProfileRepositoryImpl: $e');
    }
    throw Exception('Error in fetchAvatar() UserProfileRepositoryImpl');
  }
}
