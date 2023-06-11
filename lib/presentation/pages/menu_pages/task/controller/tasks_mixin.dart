import 'package:flutter/material.dart';
import 'package:todo2/data/repository/task_repository_impl.dart';
import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/services/dependency_service/dependency_service.dart';

mixin TasksMixin {
  final taskRepository = getIt<TaskRepositoryImpl>();

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
