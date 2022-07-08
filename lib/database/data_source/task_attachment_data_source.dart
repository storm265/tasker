import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/storage_scheme.dart';
import 'package:todo2/database/database_scheme/task_attachments_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class TaskAttachmentsDataSource {
  Future putAttachment({required String url});
  Future uploadFile({required String path, required File file});
  Future fetchAttachment();
  Future fetchAvatar();
}

class TaskAttachmentsDataSourceImpl implements TaskAttachmentsDataSource {
  final String _table = 'task_attachment';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<PostgrestResponse<dynamic>> putAttachment(
      {required String url}) async {
    try {
      final response = await _supabase.from(_table).insert({
        TaskAttachmentsScheme.url: url,
        TaskAttachmentsScheme.taskId: _supabase.auth.currentUser!.id,
        TaskAttachmentsScheme.createdAt: DateTime.now().toString()
      }).execute();
      if (response.hasError) {
        log(response.error!.message);
      }
      return response;
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchAttachment() async {
    try {
      final response = await _supabase
          .from(_table)
          .select('*')
          .eq(TaskAttachmentsScheme.taskId, _supabase.auth.currentUser!.id)
          .execute();
      if (response.hasError) {
        log(response.error!.message);
      }
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in TaskAttachmentsDataSourceImpl fetchAttachment() dataSource:  $e');
      rethrow;
    }
  }

  @override
  Future<void> uploadFile({required String path, required File file}) async {
    try {
      await _supabase.storage.from(StorageScheme.avatar).upload(path, file);
    } catch (e) {
      ErrorService.printError(
          ' TaskAttachmentsDataSourceImpl uploadAvatar error: $e');
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchAvatar() async {
    try {
      final response = await _supabase
          .from(_table)
          .select(StorageScheme.avatarUrl)
          .eq(StorageScheme.avatar, _supabase.auth.currentUser!.id)
          .execute();
      if (response.hasError) {
        log(response.error!.message);
      }
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in TaskAttachmentsDataSourceImpl fetchAvatar() dataSource: $e');
      rethrow;
    }
  }
}
