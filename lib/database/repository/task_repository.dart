import 'dart:developer';

import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/model/task_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TaskRepository<T> {
  Future fetchTask();
  // Future putData({
  //   required String color,
  //   required String title,
  // });
}

class ProjectRepositoryImpl implements TaskRepository {
  final _taskDataSource = TaskDataSourceImpl();
  @override
  Future<List<TaskModel>> fetchTask() async {
    try {
      final response = await _taskDataSource.fetchTask();
      log(response.data.toString());
      return (response.data as List<dynamic>)
          .map((json) => TaskModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProject() repository $e');
      rethrow;
    }
  }

  // @override
  // Future<void> putData({
  //   required String color,
  //   required String title,
  // }) async {
  //   try {
  //     await _projectDataSource.putData(
  //       color: color,
  //       title: title,
  //     );
  //   } catch (e) {
  //     ErrorService.printError(
  //         'Error in ProjectRepositoryImpl putData() repository $e');
  //     rethrow;
  //   }
  // }
}
