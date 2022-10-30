import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/scheme/tasks/task_dao.dart';
import 'package:todo2/database/scheme/tasks/task_database.dart';
import 'package:todo2/services/cache_service/cache_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

mixin TasksMixin {
  final taskRepository = TaskRepositoryImpl(
    inMemoryCache: InMemoryCache(),
    taskDao: TaskDaoImpl(
      TaskDatabase(),
    ),
    taskDataSource: TaskDataSourceImpl(
      network: NetworkSource(),
      secureStorage: SecureStorageSource(),
    ),
  );

  Future<void> deleteTask({
    required String taskId,
    VoidCallback? callback,
  }) async =>
      await taskRepository.deleteTask(taskId: taskId).then(
            (_) => callback != null ? callback() : null,
          );

  Future<List<UserProfileModel>> taskMemberSearch(
          {required String userName}) async =>
      await taskRepository.taskMemberSearch(nickname: userName);
}
