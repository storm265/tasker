import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

abstract class UserProfileDataSource {
  Future<Map<String, dynamic>> fetchCurrentUser({
    required String id,
    required String accessToken,
  });
  Future<Map<String, dynamic>> fetchUserStatistics();

  Future<Map<String, dynamic>> uploadAvatar({
    required String name,
    required File file,
  });
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final SecureStorageSource _secureStorageService;
  final NetworkSource _network;

  UserProfileDataSourceImpl({
    required SecureStorageSource secureStorageService,
    required NetworkSource network,
  })  : _secureStorageService = secureStorageService,
        _network = network;

  final _userPath = '/users';
  final _userStats = '/users-statistics';
  final _storagePath = '/users-avatar';

  @override
  Future<Map<String, dynamic>> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    try {
     
      final response = await _network.get(
        path: '$_userPath/$id',
        options: _network.getRequestOptions(accessToken: accessToken),
      );
      return NetworkErrorService.isSuccessful(response)
          ? response.data[UserDataScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[UserDataScheme.data][UserDataScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> fetchUserStatistics() async {
    try {
      final id =
          await _secureStorageService.getUserData(type: StorageDataType.id);

      final response = await _network.get(
          path: '$_userStats/$id',
          options: await _network.getLocalRequestOptions());
      return NetworkErrorService.isSuccessful(response)
          ? response.data[UserDataScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[UserDataScheme.data][UserDataScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> uploadAvatar({
    required String name,
    required File file,
  }) async {
    try {
      String fileName = file.path.split('/').last;

      var formData = FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
          AuthScheme.userId:
              await _secureStorageService.getUserData(type: StorageDataType.id),
        },
      );
      final response = await _network.post(
        path: _storagePath,
        formData: formData,
        data: formData,
        isFormData: true,
        options: _network.getRequestOptions(
          useMultiPart: true,
          accessToken: await _secureStorageService.getUserData(
                  type: StorageDataType.accessToken) ??
              'null',
        ),
      );
      log('uploadAvatar  ${response.data}');

      return NetworkErrorService.isSuccessful(response)
          ? response.data[UserDataScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[UserDataScheme.data][UserDataScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
