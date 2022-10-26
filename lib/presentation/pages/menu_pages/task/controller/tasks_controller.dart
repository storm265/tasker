import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';

class TaskListController extends TaskList {
  TaskListController({
    required super.taskRepository,
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
    final list1 = await fetchUserTasks();
    final list2 = await fetchAssignedToTasks();
    final list3 = await fetchParticipateInTasks();
    for (var i = 0; i < list1.length; i++) {
      tasks.value.add(list1[i]);
    }
    for (var i = 0; i < list2.length; i++) {
      tasks.value.add(list2[i]);
    }
    for (var i = 0; i < list3.length; i++) {
      tasks.value.add(list3[i]);
    }
    // TODO JUST TEST
    await FlutterDynamicIcon.setApplicationIconBadgeNumber(tasks.value.length);
    tasks.notifyListeners();
  }

  Future<List<TaskModel>> fetchUserTasks() async =>
      await taskRepository.fetchUserTasks();

  Future<List<TaskModel>> fetchAssignedToTasks() async =>
      await taskRepository.fetchAssignedToTasks();

  Future<List<TaskModel>> fetchParticipateInTasks() async =>
      await taskRepository.fetchParticipateInTasks();
}
