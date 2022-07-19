import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({required String name, required File file});
  Future updateAvatar({required String name, required File file});
}

class AvatarStorageDataSourceImpl implements AvatarStorageDataSource {
  final _storagePath = 'avatar';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<StorageResponse<String>> updateAvatar(
      {required String name, required File file}) async {
    try {
      final response = await _supabase.storage
          .from(_storagePath)
          .update('$_storagePath/public$name', file);
      log('file: ${file.path}');
      log('error: ${response.error!.message}');

      return response;
    } catch (e) {
      ErrorService.printError(
          'AvatarStorageDataSourceImpl updateAvatar  error: $e');
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
