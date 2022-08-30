import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
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
  final SecureStorageService _secureStorageService;
  UserProfileDataSourceImpl({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;
  final _network = NetworkSource().networkApiClient;

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
          ? response.data[AuthScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
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
          ? response.data[AuthScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
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
          "file=@": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
          AuthScheme.userId:
              await _secureStorageService.getUserData(type: StorageDataType.id),
        },
      );
      final response = await _network.post(
          path: _storagePath,
          data: formData,
          isFormData: true,
          options: Options(
            contentType: 'Content-Type: multipart/form-data;',
            validateStatus: (_) => true,
            headers: {
              'Authorization':
                  'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJodHRwOi8vMC4wLjAuMDo4MDgwLyIsImlzcyI6Imh0dHA6Ly8wLjAuMC4wOjgwODAvIiwiZXhwIjoxNjYyMDM0MzU5LCJlbWFpbCI6ImphamFAbWFpbC5ydSJ9.L1ofgo5GCi3NGqg1tD3EvLBAprHmEfxti_c10ekNuEU',
            },
          )
          // options: _network.getRequestOptions(
          //   accessToken: await _secureStorageService.getUserData(
          //           type: StorageDataType.accessToken) ??
          //       'null',
          // ),
          );
      //   "Content-Type": undefined
      log('uploadAvatar repo ${response.data}');
      return response.data[AuthScheme.data] as Map<String, dynamic>;
    } catch (e, t) {
      log('Trace ${t.toString()}');
      throw Failure(e.toString());
    }
  }
}
