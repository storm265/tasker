import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/database_scheme/task_scheme.dart';
import 'package:todo2/database/model/task_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TaskRepository<T> {
  Future fetchTaskId({required String title});
  Future fetchTask();
  Future postTask({
    required String title,
    required String description,
    required int assignedTo,
    required int projectId,
    required DateTime dueDate,
  });
}

class TaskRepositoryImpl implements TaskRepository {
  final _taskDataSource = TaskDataSourceImpl();
  @override
  Future<List<TaskModel>> fetchTask() async {
    try {
      final response = await _taskDataSource.fetchTask();
      return (response.data as List<dynamic>)
          .map((json) => TaskModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchTask() repository $e');
      rethrow;
    }
  }

  @override
  Future<int> fetchTaskId({required String title}) async {
    try {
      final response = await _taskDataSource.fetchTaskId(title: title);
      return response.data[0][TaskScheme.id];
    } catch (e) {
      ErrorService.printError(
          'Error in TaskRepositoryImpl fetchTaskId() repository $e');
      rethrow;
    }
  }

  @override
  Future<void> postTask({
    required String title,
    required String description,
    required int assignedTo,
    required int projectId,
    required DateTime dueDate,
  }) async {
    try {
      await _taskDataSource.putTask(
        title: title,
        assignedTo: assignedTo,
        description: description,
        dueDate: dueDate,
        projectId: projectId,
      );
    } catch (e) {
      ErrorService.printError('Error in  ProjectRepositoryImpl putTask(): $e');
      rethrow;
    }
  }
}
