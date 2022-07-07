import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/task_attachments_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class TaskAttachmentsDataSource {
  Future putAttachment({required String url});
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
}
