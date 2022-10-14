import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/delete_task_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/storage/secure_storage_service.dart';

enum TaskSortMode {
  incomplete,
  completed,
  all,
}

class TaskListController extends ChangeNotifier
    with AccessTokenMixin, DeleteTaskMixin {
  final TaskRepositoryImpl taskRepository;
  final secureStorage = SecureStorageSource();
  TaskListController({
    required this.taskRepository,
  });
  String userId = '';

  final calendarController = AdvancedCalendarController.today();

  final isTuneIconActive = ValueNotifier(true);

  final tuneIconStatus = ValueNotifier(TaskSortMode.all);

  final List<DateTime> events = [];

  List<TaskModel> tasks = [];

  void changeTuneIconValue(int index) {
    switch (index) {
      case 0:
        tuneIconStatus.value = TaskSortMode.incomplete;
        break;
      case 1:
        tuneIconStatus.value = TaskSortMode.completed;
        break;
      case 2:
        tuneIconStatus.value = TaskSortMode.all;
        break;
      default:
    }
    tuneIconStatus.notifyListeners();
  }

  void changeTuneIconStatus(bool isMonthMode) {
    isTuneIconActive.value = isMonthMode;
    isTuneIconActive.notifyListeners();
  }

  Future<void> fetchInitData(VoidCallback callback) async {
    await getUserId();
    await fetchTasks();
    generateCalendarEvents();
    callback();
  }

  Future<void> getUserId() async {
    userId = await secureStorage.getUserData(type: StorageDataType.id) ?? '';
  }

  void generateCalendarEvents() {
    for (var i = 0; i < tasks.length; i++) {
      events.add(tasks[i].dueDate);
    }
  }


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
  }

  Future<List<TaskModel>> fetchUserTasks() async =>
      await taskRepository.fetchUserTasks();

  Future<List<TaskModel>> fetchAssignedToTasks() async =>
      await taskRepository.fetchAssignedToTasks();

  Future<List<TaskModel>> fetchParticipateInTasks() async =>
      await taskRepository.fetchParticipateInTasks();
}
