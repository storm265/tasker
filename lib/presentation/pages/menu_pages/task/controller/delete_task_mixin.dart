import 'package:todo2/database/repository/task_repository.dart';

mixin DeleteTaskMixin {
  final taskRepository = TaskRepositoryImpl();
  Future<void> deleteTask({required String taskId}) async =>
      await taskRepository.deleteTask(taskId: taskId);
}

