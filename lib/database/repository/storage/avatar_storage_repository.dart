import 'dart:developer';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/data_source/storage/avatar_storage_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/storage/tokens_storage.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({required String name, required File file});
  Future updateAvatar({required String bucketImage, required File file});
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
  Future<void> uploadAvatar({required String name, required File file}) async {
    try {
     // avatarDataSource.uploadAvatar(name: name, file: file);
    } catch (e) {
      ErrorService.printError(
          'AvatarStorageReposiroryImpl uploadAvatar error: $e');
    }
  }
}
