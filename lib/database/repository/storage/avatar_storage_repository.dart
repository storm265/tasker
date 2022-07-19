import 'dart:io';
import 'package:todo2/database/data_source/storage/avatar_storage_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({required String name, required File file});
  Future updateAvatar({required String name, required File file});
}

class AvatarStorageReposiroryImpl implements AvatarStorageDataSource {
  final AvatarStorageDataSourceImpl avatarDataSource;

  AvatarStorageReposiroryImpl({required this.avatarDataSource});

  @override
  Future<void> updateAvatar({required String name, required File file}) async {
    try {
      avatarDataSource.updateAvatar(name: name, file: file);
    } catch (e) {
      ErrorService.printError(
          'AvatarStorageReposiroryImpl updateAvatar  error: $e');
    }
  }

  @override
  Future<void> uploadAvatar({required String name, required File file}) async {
    try {
      avatarDataSource.uploadAvatar(name: name, file: file);
    } catch (e) {
      ErrorService.printError(
          'AvatarStorageReposiroryImpl uploadAvatar error: $e');
    }
  }
}
