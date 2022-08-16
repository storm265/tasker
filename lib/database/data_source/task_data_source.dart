import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:todo2/database/database_scheme/task_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';

abstract class TaskDataSource {
  Future fetchTask();
  Future putTask({
    required String title,
    required String description,
    required int assignedTo,
    required int projectId,
    required DateTime dueDate,
  });
  Future fetchTaskId({required String title});
}

class TaskDataSourceImpl implements TaskDataSource {
  final String _table = 'tasks';
  final _supabase = NetworkSource().networkApiClient;
  @override
  Future<Response<dynamic>> fetchTask() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select()
      //     .eq(TaskScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .execute();
      // if (response.hasError) {
      //   log(response.error!.message);
      // }
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> fetchTaskId({required String title}) async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(TaskScheme.id)
      //     .eq(TaskScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .eq(TaskScheme.title, title)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> putTask({
    required String title,
    required String description,
    required int assignedTo,
    required int projectId,
    required DateTime dueDate,
  }) async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   TaskScheme.title: title,
      //   TaskScheme.description: description,
      //   TaskScheme.assignedTo: assignedTo,
      //   TaskScheme.projectId: projectId,
      //   TaskScheme.dueDate: dueDate.toString(),
      //   TaskScheme.isCompleted: false,
      //   TaskScheme.ownerId: _supabase.auth.currentUser!.id,
      //   TaskScheme.createdAt: DateTime.now().toString(),
      // }).execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
