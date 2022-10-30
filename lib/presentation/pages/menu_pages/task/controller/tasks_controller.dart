import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';

class TaskListController extends TaskList {
  TaskListController({
    required super.secureStorage,
    required super.calendarProvider,
  });

  @override
  Future<void> getInitData({
    required VoidCallback callback,
    String? projectId,
  }) async {
    await getUserId();
    await fetchTasks();
    generateCalendarEvents();
    callback();
  }

  Future<void> fetchTasks() async {
    final allTasks = await taskRepository.fetchAllTasks();
    tasks.value = allTasks;

    tasks.notifyListeners();
  }
}
