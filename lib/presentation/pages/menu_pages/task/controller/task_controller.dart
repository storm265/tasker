import 'package:flutter/cupertino.dart';
import 'package:todo2/database/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/controller.dart';
import 'package:todo2/services/error_service/error_service.dart';

class TaskController extends ChangeNotifier {
  static final TaskController _instance = TaskController._internal();

  factory TaskController() => _instance;

  TaskController._internal();

  final taskList = ValueNotifier<List<TaskModel>>([...taskModel]);
  final _taskRepository = TaskRepositoryImpl();

  final calendarControllerToday = AdvancedCalendarController.today();

  final List<DateTime> events = [
    DateTime.utc(2022, 09, 19, 12),
    DateTime.utc(2022, 09, 20, 12),
    DateTime.utc(2022, 09, 21, 12),
    DateTime.utc(2022, 09, 22, 12),
    DateTime.utc(2022, 09, 23, 12),
  ];

  Future<void> createTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
    List<String>? members,
  }) async {
    try {
      final model = await _taskRepository.createTask(
        title: title,
        description: description,
        assignedTo: assignedTo,
        projectId: projectId,
        dueDate: dueDate,
      );
      taskList.value.add(model);
      taskList.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteTask({required String projectId}) async {
    try {
      await _taskRepository.deleteTask(projectId: projectId);
      taskList.value.removeWhere((element) => element.id == projectId);
      taskList.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
    List<String>? members,
  }) async {
    try {
      final updatedModel = await _taskRepository.updateTask(
        title: title,
        description: description,
        assignedTo: assignedTo,
        projectId: projectId,
        dueDate: dueDate,
      );
      for (var i = 0; i < taskList.value.length; i++) {
        if (taskList.value[i].id == updatedModel.id) {
          taskList.value[i] = updatedModel;
          break;
        }
      }
      taskList.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
