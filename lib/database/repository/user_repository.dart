import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo2/database/data_source/user_profile_data_source.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';

abstract class UserProfileRepository {
  Future fetchAvatarFromStorage({required String publicUrl});
  Future<void> postProfile({
    required String avatarUrl,
    required String username,
    required String id,
  });
  Future fetchUserWhere({required String userName});
  Future fetchAvatar();
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final _userProfileDataSource = UserProfileDataSourceImpl();
  final _storage = 'avatar';
  final _supabase = NetworkSource().networkApiClient;

  @override
  Future<Response<dynamic>> postProfile({
    required String avatarUrl,
    required String username,
    required String id,
  }) async {
    try {
      final response = await _userProfileDataSource.postUserProfile(
        id: id,
        avatarUrl: avatarUrl,
        username: username,
      );
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ) UserProfileRepositoryImpl postProfile(: $e');
      rethrow;
    }
  }

  @override
  Future<String> fetchAvatarFromStorage({required String publicUrl}) async {
    try {
      // final imageResponce =
      //     _supabase.storage.from(_storage).getPublicUrl(publicUrl);
      // final image = imageResponce.data;
      // return image!;
      return Future.delayed(Duration(seconds: 1));
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
      final image = await response.data[0][UserProfileScheme.avatarPath];
      log(' fetchAvatar repo: $image');
      return image;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileRepositoryImpl fetchAvatar() : $e');
      rethrow;
    }
  }

  @override
  Future<List<UserProfileModel>> fetchUserWhere(
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
}
