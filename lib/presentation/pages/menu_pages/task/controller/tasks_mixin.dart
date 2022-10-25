import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/repository/task_repository.dart';

mixin TasksMixin {
  final taskRepository = TaskRepositoryImpl();
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
