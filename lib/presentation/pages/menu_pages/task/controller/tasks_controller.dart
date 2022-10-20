import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/delete_task_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class TaskListController extends ChangeNotifier with DeleteTaskMixin {
  final TaskRepositoryImpl taskRepository;
  final SecureStorageSource _secureStorage;
  final CalendarProvider calendarProvider;
  TaskListController({
    required this.taskRepository,
    required SecureStorageSource secureStorage,
    required this.calendarProvider,
  }) : _secureStorage = secureStorage;

  String userId = '';

  final selectedDate = AdvancedCalendarController.today();

  final isTuneIconActive = ValueNotifier(true);

  final sortMode = ValueNotifier(TasksSortMode.all);

  final List<DateTime> events = [];

  final tasks = ValueNotifier<List<TaskModel>>([]);

  void removeTaskItem(String taskId) {
    tasks.value.where((element) => element.id == taskId);
    tasks.notifyListeners();
  }

  void updateTaskItem(TaskModel updatedModel) {
    for (var i = 0; i < tasks.value.length; i++) {
      if (tasks.value[i].id == updatedModel.id) {
        tasks.value[i] == updatedModel;
      }
    }
    tasks.notifyListeners();
  }

  void changeTuneIconValue(int index) {
    switch (index) {
      case 0:
        sortMode.value = TasksSortMode.incomplete;
        break;
      case 1:
        sortMode.value = TasksSortMode.completed;
        break;
      case 2:
        sortMode.value = TasksSortMode.all;
        break;
      default:
    }
    sortMode.notifyListeners();
  }

  void changeTuneIconVisibility(bool isMonthMode) {
    isTuneIconActive.value = isMonthMode;
    isTuneIconActive.notifyListeners();
  }

  Future<void> getInitData(VoidCallback callback) async {
    await getUserId();
    await fetchTasks();
    generateCalendarEvents();
    callback();
  }

  Future<void> getUserId() async {
    userId = await _secureStorage.getUserData(type: StorageDataType.id) ?? '';
  }

  void generateCalendarEvents() {
    for (var i = 0; i < tasks.value.length; i++) {
      events.add(tasks.value[i].dueDate);
    }
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
    tasks.notifyListeners();
  }

  Future<List<TaskModel>> fetchUserTasks() async =>
      await taskRepository.fetchUserTasks();

  Future<List<TaskModel>> fetchAssignedToTasks() async =>
      await taskRepository.fetchAssignedToTasks();

  Future<List<TaskModel>> fetchParticipateInTasks() async =>
      await taskRepository.fetchParticipateInTasks();
}
