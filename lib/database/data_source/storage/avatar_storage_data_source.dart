import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({
    required String name,
    required File file,
  });
  Future updateAvatar({required String bucketImage, required File file});
}

class AvatarStorageDataSourceImpl implements AvatarStorageDataSource {
  final _storagePath = '/users-avatar';
  final _network = NetworkSource().networkApiClient;
  final _storageSource = SecureStorageSource().storageApi;
  @override
  Future<Response<String>> updateAvatar(
      {required String bucketImage, required File file}) async {
    try {
      // final response = await _network.storage.from(_storagePath).update(
      //     bucketImage, file,
      //     fileOptions: const FileOptions(cacheControl: '3600', upsert: false));
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e, t) {
      ErrorService.printError(
          'AvatarStorageDataSourceImpl updateAvatar  error: $e, $t');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> uploadAvatar({
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
      log(' file.path: ${file.path}');
      log(' fileName: $fileName');
      final response = await _network.dio.post(_storagePath,
          data: formData,
          options: _network.getRequestOptions(
              accessToken: await _storageSource.getUserData(
                      type: StorageDataType.accessToken) ??
                  'null'));
      log('response.data: ${response.data}');
      return response;
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
      rethrow;
    }
  }
}
