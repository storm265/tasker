import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/task_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class TaskDataSource {
  Future fetchTask();
  Future putTask({
    required String title,
    required String description,
    required int assignedTo,
    required int projectId,
    required DateTime dueDate,
  });
}

class TaskDataSourceImpl implements TaskDataSource {
  final String _table = 'tasks';
  final _supabase = SupabaseSource().restApiClient;
  @override
  Future<PostgrestResponse<dynamic>> fetchTask() async {
    try {
      final response = await _supabase
          .from(_table)
          .select('*')
          .eq(TaskScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
      if (response.hasError) {
        log(response.error!.message);
      }
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchProject() dataSource:  $e');
      rethrow;
    }
  }


  @override
  Future<PostgrestResponse<dynamic>> putTask({
    required String title,
    required String description,
    required int assignedTo,
    required int projectId,
    required DateTime dueDate,
  }) async {
    try {
      final response = await _supabase.from(_table).insert({
        TaskScheme.title: title,
        TaskScheme.description: description,
        TaskScheme.assignedTo: assignedTo,
        TaskScheme.projectId: projectId,
        TaskScheme.dueDate: dueDate.toString(),
        TaskScheme.isCompleted: false,
        TaskScheme.ownerId: _supabase.auth.currentUser!.id,
        TaskScheme.createdAt: DateTime.now().toString(),
      }).execute();
      return response;
    } catch (e) {
      ErrorService.printError('Error in putTask() data source:$e');
      rethrow;
    }
  }
}
