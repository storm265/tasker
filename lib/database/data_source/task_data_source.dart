import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/task_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

abstract class TaskDataSource {
  Future<void> createTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
    List<String>? members,
  });
  Future<void> deleteTask({required String projectId});

  Future fetchTask();
  Future fetchTaskId({required String title});
}

class TaskDataSourceImpl implements TaskDataSource {
  final String _tasks = '/tasks';
  final NetworkSource _network;
  final SecureStorageSource _secureStorage;
  TaskDataSourceImpl({
    required NetworkSource network,
    required SecureStorageSource secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

  @override
  Future<void> createTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
    List<String>? members,
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      await _network.post(
        path: _tasks,
        data: {
          TaskScheme.title: title,
          TaskScheme.dueDate: dueDate,
          TaskScheme.description: description,
          TaskScheme.assignedTo: assignedTo,
          TaskScheme.isCompleted: false,
          TaskScheme.projectId: projectId, // id of project (menu)
          TaskScheme.ownerId: ownerId,
          TaskScheme.members: members,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteTask({required String projectId}) async {
    try {
      await _network.delete(
        path: '$_tasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

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
}
