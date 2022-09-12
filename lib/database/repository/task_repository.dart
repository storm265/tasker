import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/database_scheme/task_scheme.dart';
import 'package:todo2/database/model/task_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

List<TaskModel> taskModel = [
  TaskModel(
    title: 'title',
    dueDate: '2025-06-21T23:56:02.394631',
    description: 'description',
    assignedTo: 1,
    isCompleted: true,
    projectId: 2,
    ownerId: 'ownerId',
    createdAt: '2022-07-13T09:16:30.841251',
  ),
  TaskModel(
    title: 'title',
    dueDate: '2025-06-21T23:56:02.394631',
    description: 'description',
    assignedTo: 1,
    isCompleted: true,
    projectId: 2,
    ownerId: 'ownerId',
    createdAt: '2022-07-13T09:16:30.841251',
  ),
  TaskModel(
    title: 'title',
    dueDate: '2025-06-21T23:56:02.394631',
    description: 'description',
    assignedTo: 1,
    isCompleted: true,
    projectId: 2,
    ownerId: 'ownerId',
    createdAt: '2022-07-13T09:16:30.841251',
  ),
  TaskModel(
    title: 'title',
    dueDate: '2025-06-21T23:56:02.394631',
    description: 'description',
    assignedTo: 1,
    isCompleted: true,
    projectId: 2,
    ownerId: 'ownerId',
    createdAt: '2022-07-13T09:16:30.841251',
  ),
];

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
  // final _taskDataSource = TaskDataSourceImpl(

  // );
  @override
  Future<List<TaskModel>> fetchTask() async {
    try {
      // final response = await _taskDataSource.fetchTask();
      // return (response.data as List<dynamic>)
      //     .map((json) => TaskModel.fromJson(json))
      //     .toList();
      return taskModel;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<int> fetchTaskId({required String title}) async {
    try {
      throw Failure('');
      // final response = await _taskDataSource.fetchTaskId(title: title);
      // return response.data[0][TaskScheme.id];
    } catch (e) {
      throw Failure(e.toString());
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
      throw Failure('');
      // await _taskDataSource.createTask(
      //   title: title,
      //   assignedTo: assignedTo,
      //   description: description,
      //   dueDate: dueDate,
      //   projectId: projectId,
      // );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
