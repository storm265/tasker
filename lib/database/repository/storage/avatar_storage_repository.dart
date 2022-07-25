import 'dart:io';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/data_source/storage/avatar_storage_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({
    required String name,
    required File file,
    required String userId,
  });
  Future updateAvatar({
    required String bucketImage,
    required File file,
  });
}

class AvatarStorageReposiroryImpl implements AvatarStorageDataSource {
  final AvatarStorageDataSourceImpl avatarDataSource;

  AvatarStorageReposiroryImpl({required this.avatarDataSource});

  @override
  Future<StorageResponse<String>> updateAvatar(
      {required String bucketImage, required File file}) async {
    try {
      final response = await avatarDataSource.updateAvatar(
          bucketImage: bucketImage, file: file);
      return response;
    } catch (e, t) {
      ErrorService.printError(
          'AvatarStorageReposiroryImpl updateAvatar  error: $e, $t');
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
      final response = await avatarDataSource.uploadAvatar(
          name: name, file: file, userId: userId);
      return response;
    } catch (e) {
      ErrorService.printError(
          'AvatarStorageReposiroryImpl uploadAvatar error: $e');
      rethrow;
    }
  }
}
