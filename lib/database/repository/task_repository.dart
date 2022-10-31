import 'dart:developer';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/scheme/tasks/task_dao.dart';
import 'package:todo2/database/scheme/tasks/task_database.dart';
import 'package:todo2/services/cache_service/cache_service.dart';

abstract class TaskRepository<T> {
  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String? dueDate,
    List<Map<String, dynamic>>? attachments,
    List<String>? members,
  });

  Future<void> deleteTask({required String taskId});

  Future<TaskModel> updateTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String taskId,
    required bool isCompleted,
    required String? dueDate,
    List<String>? members,
  });

  Future<TaskModel> fetchOneTask({required String projectId});

  Future<TaskModel> fetchProjectTasks({required String projectId});

  Future<List<TaskModel>> fetchUserTasks();

  Future<List<TaskModel>> fetchAssignedToTasks();

  Future<List<TaskModel>> fetchParticipateInTasks();

  Future<CommentModel> createTaskComment({
    required String content,
    required String taskId,
  });

  Future<void> uploadTaskAttachment({
    required String name,
    required File file,
    required String taskId,
    required bool isFile,
  });
  Future<List<CommentModel>> fetchTaskComments({required String taskId});

  Future<List<UserProfileModel>> taskMemberSearch({required String nickname});

  Future<void> deleteTaskComment({required String taskId});

  Future<void> uploadTaskCommentAttachment({
    required File file,
    required String taskId,
    required bool isFile,
  });

  Future<List<TaskModel>> fetchAllTasks();
}

class TaskRepositoryImpl implements TaskRepository {
  final InMemoryCache _inMemoryCache;
  final TaskDao _taskDao;
  final TaskDataSource _taskDataSource;

  TaskRepositoryImpl({
    required TaskDao taskDao,
    required InMemoryCache inMemoryCache,
    required TaskDataSource taskDataSource,
  })  : _taskDataSource = taskDataSource,
        _taskDao = taskDao,
        _inMemoryCache = inMemoryCache;

  @override
  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String? dueDate,
    List<Map<String, dynamic>>? attachments,
    List<String>? members,
  }) async {
    final response = await _taskDataSource.createTask(
      title: title,
      description: description,
      assignedTo: assignedTo,
      projectId: projectId,
      dueDate: dueDate,
      attachments: attachments,
      members: members,
    );
    return TaskModel.fromJson(response);
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    await _taskDataSource.deleteTask(projectId: taskId);
  }

  @override
  Future<TaskModel> updateTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String taskId,
    required String? dueDate,
    required bool isCompleted,
    List<String>? members,
  }) async {
    final response = await _taskDataSource.updateTask(
      taskId: taskId,
      title: title,
      isCompleted: isCompleted,
      description: description,
      assignedTo: assignedTo,
      projectId: projectId,
      dueDate: dueDate,
    );
    return TaskModel.fromJson(response);
  }

  @override
  Future<TaskModel> fetchOneTask({required String projectId}) async {
    final response = await _taskDataSource.fetchOneTask(projectId: projectId);
    return TaskModel.fromJson(response);
  }

  @override
  Future<List<TaskModel>> fetchAllTasks() async {
    if (_inMemoryCache.shouldFetchOnlineData(
        date: DateTime.now(), key: CacheKeys.tasks)) {
      log('online fetch tasks');

      final userTasks = await fetchUserTasks();

      final assignedToTasks = await fetchAssignedToTasks();

      final participateInTasks = await fetchParticipateInTasks();

      List<TaskModel> allTasks = [
        ...assignedToTasks,
        ...userTasks,
        ...participateInTasks
      ]
        ..toSet()
        ..toList();
      log('allTasks before clean len ${allTasks.length}');
      //TODO WTF
      final copiedList = allTasks;

      for (var i = 0; i < allTasks.length; i++) {
        if (allTasks[i].id == copiedList[i].id) {
          // log('is equal ${allTasks[i].id}  - ${allTasks[i].id == copiedList[i].id} - ${copiedList[i].id}');
          allTasks.removeAt(i);
        }
      }
      for (var i = 0; i < allTasks.length; i++) {
        if (allTasks[i].id == copiedList[i].id) {
          // log('is equal ${allTasks[i].id}  - ${allTasks[i].id == copiedList[i].id} - ${copiedList[i].id}');
          allTasks.removeAt(i);
        }
      }
      log('userTasks ${userTasks.length}');
      log('assignedToTasks ${assignedToTasks.length}');
      log('participateInTasks ${participateInTasks.length}');
      log('allTasks len ${allTasks.length}');

      await _taskDao.deleteAllTasks();

      for (int i = 0; i < allTasks.length; i++) {
        log('i $i ${allTasks[i].id}');

        await _taskDao.insertTask(
          TaskTableCompanion(
            assignedTo: Value(allTasks.elementAt(i).assignedTo),
            createdAt: Value(allTasks.elementAt(i).createdAt.toIso8601String()),
            description: Value(allTasks.elementAt(i).description),
            dueDate: Value(allTasks.elementAt(i).dueDate.toIso8601String()),
            id: Value(allTasks.elementAt(i).id),
            isCompleted: Value(allTasks.elementAt(i).isCompleted),
            ownerId: Value(allTasks.elementAt(i).ownerId),
            projectId: Value(allTasks.elementAt(i).projectId),
            title: Value(allTasks.elementAt(i).title),
          ),
        );
      }

      return allTasks;
    } else {
      log('locally fetch tasks');

      final list = await _taskDao.getTasks();
      final List<TaskModel> tasks = [];
      for (int i = 0; i < list.length; i++) {
        tasks.add(TaskModel.fromJson(list[i].toJson()));
      }

      return tasks;
    }
  }

  @override
  Future<TaskModel> fetchProjectTasks({required String projectId}) async {
    final response =
        await _taskDataSource.fetchProjectTasks(projectId: projectId);
    final listModel = response.map((json) => TaskModel.fromJson(json)).toList();
    return listModel[0];
  }

  @override
  Future<List<TaskModel>> fetchUserTasks() async {
    final response = await _taskDataSource.fetchUserTasks();
    if (response.isEmpty) {
      return [];
    } else {
      return response.map((json) => TaskModel.fromJson(json)).toList();
    }
  }

  @override
  Future<List<TaskModel>> fetchAssignedToTasks() async {
    final response = await _taskDataSource.fetchAssignedToTasks();

    if (response.isEmpty) {
      return [];
    } else {
      return response.map((json) => TaskModel.fromJson(json)).toList();
    }
  }

  @override
  Future<List<TaskModel>> fetchParticipateInTasks() async {
    final response = await _taskDataSource.fetchParticipateInTasks();
    if (response.isEmpty) {
      return [];
    } else {
      return response.map((json) => TaskModel.fromJson(json)).toList();
    }
  }

  @override
  Future<void> uploadTaskAttachment({
    required String name,
    required File file,
    required String taskId,
    required bool isFile,
  }) async {
    await _taskDataSource.uploadTaskAttachment(
      name: name,
      file: file,
      taskId: taskId,
      isFile: isFile,
    );
  }

  @override
  Future<CommentModel> createTaskComment({
    required String content,
    required String taskId,
  }) async {
    final response = await _taskDataSource.createTaskComment(
      content: content,
      taskId: taskId,
    );
    return CommentModel.fromJson(response);
  }

  @override
  Future<List<CommentModel>> fetchTaskComments({required String taskId}) async {
    final response = await _taskDataSource.fetchTaskComments(
      taskId: taskId,
    );
    List<CommentModel> commentsList = [];
    for (int i = 0; i < response.length; i++) {
      commentsList.add(CommentModel.fromJson(response[i]));
    }
    return commentsList;
  }

  @override
  Future<List<UserProfileModel>> taskMemberSearch(
      {required String nickname}) async {
    final response = await _taskDataSource.taskMemberSearch(nickname: nickname);
    List<UserProfileModel> users = [];
    for (int i = 0; i < response.length; i++) {
      users.add(UserProfileModel.fromJson(response[i]));
    }
    return users;
  }

  @override
  Future<void> deleteTaskComment({required String taskId}) async =>
      await _taskDataSource.deleteTaskComment(taskId: taskId);

  @override
  Future<void> uploadTaskCommentAttachment({
    required File file,
    required String taskId,
    required bool isFile,
  }) async =>
      await _taskDataSource.uploadTaskCommentAttachment(
        file: file,
        commentId: taskId,
        isFile: isFile,
      );
}
