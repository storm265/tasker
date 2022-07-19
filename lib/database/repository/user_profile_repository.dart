import 'package:todo2/database/data_source/user_profile_data_source.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class UserProfileRepository {
  Future<String> fetchUserName();
 Future fetchAvatarFromStorage({required String publicUrl}) ;
  Future fetchId();
  Future<void> postProfile({
    required String avatarUrl,
    required String username,
  });
  fetchUsersWhere({required String userName});
  Future  fetchAvatar();
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final _userProfileDataSource = UserProfileDataSourceImpl();
  final _storage = 'avatar';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<void> postProfile({
    required String avatarUrl,
    required String username,
  }) async {
    try {
      await _userProfileDataSource.postUserProfile(
        avatarUrl: avatarUrl,
        username: username,
      );
    } catch (e) {
      ErrorService.printError(
          'Error in ) UserProfileRepositoryImpl postProfile(: $e');
      rethrow;
    }
  }

  @override
  Future<String> fetchUserName() async {
    try {
      final response = await _userProfileDataSource.fetchUserName();
      return response.data[0][UserProfileScheme.username] as String;
    } catch (e) {
      ErrorService.printError(
          'Error in  UserProfileRepositoryImpl fetchUserName(): $e');
      rethrow;
    }
  }

  @override
  Future<String> fetchAvatarFromStorage({required String publicUrl}) async {
    try {
      final imageResponce = _supabase.storage
          .from(_storage)
          .getPublicUrl(publicUrl);
      final image = imageResponce.data;
      return image!;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileRepositoryImpl fetchAvatarFromStorage() : $e');
      rethrow;
    }
  }

  @override
  Future<String> fetchAvatar() async {
    try {
      final response = await _userProfileDataSource.fetchAvatar();
     final image  = await response.data[0][UserProfileScheme.avatarUrl];
      return  image;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileRepositoryImpl fetchAvatar() : $e');
      rethrow;
    }
  }

  @override
  Future<List<UserProfileModel>> fetchUsersWhere(
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

  @override
  Future<int> fetchId() async {
    try {
      final response = await _userProfileDataSource.fetchUserId();
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileRepositoryImpl fetchId() : $e');
      rethrow;
    }
  }
}
