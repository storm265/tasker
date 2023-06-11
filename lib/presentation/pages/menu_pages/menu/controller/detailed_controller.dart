import 'package:flutter/cupertino.dart';
import 'package:todo2/domain/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';

class DetailedController extends TaskList {
  DetailedController({
    required super.secureStorage,
    required super.calendarProvider,
  });

  Future<List<TaskModel>> fetchProjectTasks(String projectId) async {
    return await taskRepository.fetchProjectTasks(projectId: projectId);
  }

  @override
  Future<void> getInitData({
    required VoidCallback callback,
    String? projectId,
  }) async {
    tasks.value = await fetchProjectTasks(projectId ?? '');
    tasks.notifyListeners();
    generateCalendarEvents();
    callback();
  }
}
