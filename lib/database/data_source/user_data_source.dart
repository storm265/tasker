import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/error_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

// TODO add generic
abstract class UserProfileDataSource {
  Future downloadAvatar();
  Future fetchCurrentUser({
    required String id,
    required String accessToken,
  });
  Future<Map<String, dynamic>> fetchUserStatistics();
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final SecureStorageService _secureStorageService;
  UserProfileDataSourceImpl({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;
  final _network = NetworkSource().networkApiClient;

  final _userPath = '/users';
  final _userAvatarPath = '/users-avatar/';
  final _userStats = '/users-statistics';

  @override
  Future<Map<String, dynamic>> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    try {
      final response = await _network.dio.get(
        '$_userPath/$id',
        options: _network.getRequestOptions(accessToken: accessToken),
      );
      return NetworkErrorService.isSuccessful(response)
          ? response.data[AuthScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> downloadAvatar() async {
    try {
      final userId = await _secureStorageService.getUserData(
        type: StorageDataType.id,
      );

      final response = await _network.dio.get(
        '$_userAvatarPath$userId',
        options: await _network.getLocalRequestOptions(),
      );
      debugPrint('response ${response.data}');
      return response;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> fetchUserStatistics() async {
    try {
      final id = await _secureStorageService.getUserData(
        type: StorageDataType.id,
      );

      final response = await _network.dio.get('$_userStats/$id',
          options: await _network.getLocalRequestOptions());
      return NetworkErrorService.isSuccessful(response)
          ? response.data[AuthScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
