import 'dart:developer';

import 'package:todo2/database/data_source/user_profile_data_source.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class UserProfileRepository {
  Future<String> fetchUserName();
  Future<String> fetchAvatar();
  Future fetchUserWhere({required String userName});
  Future<void> insertProfile({
    required String avatarUrl,
    required String username,
  });
  fetchUsers({required String userName});
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final _userProfileDataSource = UserProfileDataSourceImpl();
  final _storage = 'avatar';
  final _supabase = SupabaseSource().restApiClient;
  @override
  Future<void> insertProfile({
    required String avatarUrl,
    required String username,
  }) async {
    try {
      await _userProfileDataSource.insertUserProfile(
        avatarUrl: avatarUrl,
        username: username,
      );
    } catch (e) {
      ErrorService.printError(
          'Error in insertImg() UserProfileRepositoryImpl: $e');
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
          'Error in fetchUserName() UserProfileRepositoryImpl: $e');
      rethrow;
    }
  }

  @override
  Future<String> fetchAvatar() async {
    try {
      final response = await _userProfileDataSource.fetchAvatar();
      final imageResponce = _supabase.storage
          .from(_storage)
          .getPublicUrl(response.data[0][UserProfileScheme.avatarUrl]);
      final image = imageResponce.data;
      return image!;
    } catch (e) {
      ErrorService.printError(
          'Error in fetchAvatar() UserProfileRepositoryImpl: $e');
      rethrow;
    }
  }

  @override
  Future<List<UserProfileModel>> fetchUserWhere(
      {required String userName}) async {
    try {
      final response =
          await _userProfileDataSource.fetchUserWhere(userName: userName);
      log(response.data.toString());
      return (response.data as List<dynamic>)
          .map((json) => UserProfileModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchUserWhere() repository:$e');
      rethrow;
    }
  }

  @override
  Future<List<UserProfileModel>> fetchUsers({required String userName}) async {
    try {
      final response =
          await _userProfileDataSource.fetchUsers(userName: userName);

      return (response.data as List<dynamic>)
          .map((json) => UserProfileModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in repository fetchUsers(): $e');
      rethrow;
    }
  }
}
