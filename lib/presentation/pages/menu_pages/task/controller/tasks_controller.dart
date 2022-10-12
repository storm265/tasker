import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/delete_task_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';

class TaskListController extends ChangeNotifier
    with AccessTokenMixin, DeleteTaskMixin {
  final TaskRepository _taskRepository;

  final isTuneIconActive = ValueNotifier(true);
  final calendarController = AdvancedCalendarController.today();

  TaskListController({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;
  void changeTuneIconStatus(bool isMonthMode) {
    isTuneIconActive.value = isMonthMode;
    isTuneIconActive.notifyListeners();
  }

  void generateCalendarEvents() {
    for (var element in tasks) {
      events.add(element.dueDate);
    }
  }

  final List<DateTime> events = [
 
  ];

  List<TaskModel> tasks = [];
  Future<void> fetchTasks() async {
    final list1 = await fetchUserTasks();
    final list2 = await fetchAssignedToTasks();
    final list3 = await fetchParticipateInTasks();
    for (var i = 0; i < list1.length; i++) {
      tasks.add(list1[i]);
    }
    for (var i = 0; i < list2.length; i++) {
      tasks.add(list2[i]);
    }
    for (var i = 0; i < list2.length; i++) {
      tasks.add(list3[i]);
    }
    log('task model length ${tasks.length}');
  }

  Future<List<TaskModel>> fetchUserTasks() async =>
      await _taskRepository.fetchUserTasks();

  Future<List<TaskModel>> fetchAssignedToTasks() async =>
      await _taskRepository.fetchAssignedToTasks();

  Future<List<TaskModel>> fetchParticipateInTasks() async =>
      await _taskRepository.fetchParticipateInTasks();



      
}
