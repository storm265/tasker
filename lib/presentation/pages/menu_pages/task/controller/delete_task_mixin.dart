import 'package:flutter/material.dart';
import 'package:todo2/database/repository/task_repository.dart';

mixin DeleteTaskMixin {
  Future<void> deleteTask({
    required String taskId,
    required TaskRepositoryImpl taskRepository,
    VoidCallback? callback,
  }) async =>
      await taskRepository.deleteTask(taskId: taskId).then(
            (_) => callback != null ? callback() : null,
          );
}
