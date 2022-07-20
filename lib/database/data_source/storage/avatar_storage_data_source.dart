import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({required String name, required File file});
  Future updateAvatar({required String bucketImage, required File file});
}

class AvatarStorageDataSourceImpl implements AvatarStorageDataSource {
  final _storagePath = 'avatar';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<StorageResponse<String>> updateAvatar(
      {required String bucketImage, required File file}) async {
    try {
      final response = await _supabase.storage.from(_storagePath).update(
          bucketImage, file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false));
      return response;
    } catch (e, t) {
      ErrorService.printError(
          'AvatarStorageDataSourceImpl updateAvatar  error: $e, $t');
      rethrow;
    }
  }

  @override
  Future<void> uploadAvatar({required String name, required File file}) async {
    try {
      await _supabase.storage.from(_storagePath).upload(name, file);
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
    }
  }
}
