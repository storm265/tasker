import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class AvatarStorageDataSource {
  Future<Map<String, dynamic>> uploadAvatar({
    required String name,
    required File file,
  });
}

class AvatarStorageDataSourceImpl implements AvatarStorageDataSource {
  final _storagePath = '/users-avatar';
  final _network = NetworkSource().networkApiClient;
  final _storageSource = SecureStorageSource().storageApi;

  @override
  Future<Map<String, dynamic>> uploadAvatar({
    required String name,
    required File file,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      var formData = FormData.fromMap(
        {
          "=@": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
          AuthScheme.userId:
              await _storageSource.getUserData(type: StorageDataType.id),
        },
      );

      final response = await _network.dio.post(
        _storagePath,
        data: formData,
        options: _network.getRequestOptions(
          accessToken: await _storageSource.getUserData(
                  type: StorageDataType.accessToken) ??
              'null',
        ),
      );

      return response.data[AuthScheme.data] as Map<String, dynamic>;
    } catch (e, t) {
      log('Trace ${t.toString()}');
      throw Failure(e.toString());
    }
  }
}
