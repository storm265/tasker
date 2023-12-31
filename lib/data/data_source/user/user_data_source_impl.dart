import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todo2/data/data_source/user/user_data_source.dart';
import 'package:todo2/schemas/database_scheme/auth_scheme.dart';
import 'package:todo2/schemas/database_scheme/user_data_scheme..dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';

class UserProfileDataSourceImpl implements UserProfileDataSource {
  UserProfileDataSourceImpl({
    required SecureStorageSource secureStorageService,
    required NetworkSource network,
  })  : _secureStorageService = secureStorageService,
        _network = network;

  final SecureStorageSource _secureStorageService;

  final NetworkSource _network;

  final _userPath = '/users';
  final _userStats = '/users-statistics';
  final _storagePath = '/users-avatar';

  @override
  Future<Map<String, dynamic>> fetchCurrentUser({
    required String id,
    required String accessToken,
  }) async {
    final response = await _network.get(
      path: '$_userPath/$id',
      options: _network.getRequestOptions(accessToken: accessToken),
    );
    return NetworkErrorService.isSuccessful(response)
        ? response.data[UserDataScheme.data] as Map<String, dynamic>
        : throw Failure(
            'Error: ${response.data[UserDataScheme.data][UserDataScheme.message]}');
  }

  @override
  Future<Map<String, dynamic>> fetchUser({required String id}) async {
    final response = await _network.get(
      path: '$_userPath/$id',
      options: await _network.getLocalRequestOptions(),
    );
    return NetworkErrorService.isSuccessful(response)
        ? response.data[UserDataScheme.data] as Map<String, dynamic>
        : throw Failure(
            'Error: ${response.data[UserDataScheme.data][UserDataScheme.message]}');
  }

  @override
  Future<Map<String, dynamic>> fetchUserStatistics() async {
    final id =
        await _secureStorageService.getUserData(type: StorageDataType.id);

    final response = await _network.get(
        path: '$_userStats/$id',
        options: await _network.getLocalRequestOptions());
    return NetworkErrorService.isSuccessful(response)
        ? response.data[UserDataScheme.data] as Map<String, dynamic>
        : throw Failure(
            'Error: ${response.data[UserDataScheme.data][UserDataScheme.message]}');
  }

  @override
  Future<Map<String, dynamic>> uploadAvatar({
    required String name,
    required File file,
  }) async {
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

    return NetworkErrorService.isSuccessful(response)
        ? response.data[UserDataScheme.data] as Map<String, dynamic>
        : throw Failure(
            'Error: ${response.data[UserDataScheme.data][UserDataScheme.message]}');
  }
}
