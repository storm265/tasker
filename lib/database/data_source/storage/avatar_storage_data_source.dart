import 'dart:io';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({
    required String name,
    required File file,
    required String userId,
  });
  Future updateAvatar({required String bucketImage, required File file});
}

class AvatarStorageDataSourceImpl implements AvatarStorageDataSource {
  final _storagePath = '/users-avatar';
  final _network = NetworkSource().networkApiClient;
  // final _storageSource = SecureStorageSource().storageApi;
  @override
  Future<StorageResponse<String>> updateAvatar(
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
    required String userId,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      var formData = FormData.fromMap(
        {
          "=@": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
          AuthScheme.userId: userId,
        },
      );

      final response = await _network.dio.post(_storagePath,
          data: formData, options: await _network.getRequestOptions());
      return response;
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
      rethrow;
    }
  }
}
