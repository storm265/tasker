import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/services/secure_storage_service.dart';

class TaskList with TasksMixin, ChangeNotifier {

  final SecureStorageSource _secureStorage;
  final CalendarProvider calendarProvider;
  TaskList({
    required SecureStorageSource secureStorage,
    required this.calendarProvider,
  }) : _secureStorage = secureStorage;

  String userId = '';

  final selectedDate = AdvancedCalendarController.today();

  final isTuneIconActive = ValueNotifier(true);

  final sortMode = ValueNotifier(TasksSortMode.all);

  final List<DateTime> events = [];

  final tasks = ValueNotifier<List<TaskModel>>([]);

  Future<void> getInitData({
    required VoidCallback callback,
    String? projectId,
  }) async {}

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

  Future<void> getUserId() async {
    userId = await _secureStorage.getUserData(type: StorageDataType.id) ?? '';
  }

  void generateCalendarEvents() {
    for (var i = 0; i < tasks.value.length; i++) {
      events.add(tasks.value[i].dueDate);
    }
  }
}
