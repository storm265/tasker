import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

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
  Future<StatsModel> fetchUserStatistics() async {
    try {
      final response = await _userProfileDataSource.fetchUserStatistics();
      return StatsModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> uploadAvatar({
    required String name,
    required File file,
  }) async {
    try {
      final response = await _userProfileDataSource.uploadAvatar(
        name: name,
        file: file,
      );

      debugPrint('avatar url ${response[AuthScheme.avatarUrl]}');
      return response[AuthScheme.avatarUrl];
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
