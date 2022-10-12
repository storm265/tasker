import 'package:todo2/database/repository/task_repository.dart';

mixin DeleteTaskMixin {
  Future<void> deleteTask({required String taskId, required TaskRepositoryImpl taskRepository,}) async =>
      await taskRepository.deleteTask(taskId: taskId);
}

