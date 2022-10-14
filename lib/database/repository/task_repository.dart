import 'dart:developer';
import 'dart:io';
import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

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
}

class TaskRepositoryImpl implements TaskRepository {
  final _taskDataSource = TaskDataSourceImpl(
    network: NetworkSource(),
    secureStorage: SecureStorageSource(),
  );

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
    try {
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
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      await _taskDataSource.deleteTask(projectId: taskId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskModel> updateTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String taskId,
    required String? dueDate,
    List<String>? members,
  }) async {
    try {
      final response = await _taskDataSource.updateTask(
        taskId: taskId,
        title: title,
        description: description,
        assignedTo: assignedTo,
        projectId: projectId,
        dueDate: dueDate,
      );
      return TaskModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskModel> fetchOneTask({required String projectId}) async {
    try {
      final response = await _taskDataSource.fetchOneTask(projectId: projectId);
      return TaskModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskModel> fetchProjectTasks({required String projectId}) async {
    try {
      final response =
          await _taskDataSource.fetchProjectTasks(projectId: projectId);
      final listModel =
          response.map((json) => TaskModel.fromJson(json)).toList();
      return listModel[0];
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<TaskModel>> fetchUserTasks() async {
    try {
      final response = await _taskDataSource.fetchUserTasks();
      if (response.isEmpty) {
        return [];
      } else {
        return response.map((json) => TaskModel.fromJson(json)).toList();
      }
    } catch (e, t) {
      log('repo $t');
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<TaskModel>> fetchAssignedToTasks() async {
    try {
      final response = await _taskDataSource.fetchAssignedToTasks();
      log('is empty ${response.isEmpty}');
      if (response.isEmpty) {
        return [];
      } else {
        return response.map((json) => TaskModel.fromJson(json)).toList();
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<TaskModel>> fetchParticipateInTasks() async {
    try {
      final response = await _taskDataSource.fetchParticipateInTasks();
      if (response.isEmpty) {
        return [];
      } else {
        return response.map((json) => TaskModel.fromJson(json)).toList();
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> uploadTaskAttachment({
    required String name,
    required File file,
    required String taskId,
    required bool isFile,
  }) async {
    try {
      await _taskDataSource.uploadTaskAttachment(
        name: name,
        file: file,
        taskId: taskId,
        isFile: isFile,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<CommentModel> createTaskComment({
    required String content,
    required String taskId,
  }) async {
    try {
      final response = await _taskDataSource.createTaskComment(
        content: content,
        taskId: taskId,
      );
      return CommentModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<CommentModel>> fetchTaskComments({required String taskId}) async {
    try {
      final response = await _taskDataSource.fetchTaskComments(
        taskId: taskId,
      );
      List<CommentModel> commentsList = [];
      for (int i = 0; i < response.length; i++) {
        commentsList.add(CommentModel.fromJson(response[i]));
      }
      return commentsList;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<UserProfileModel>> taskMemberSearch(
      {required String nickname}) async {
    try {
      final response =
          await _taskDataSource.taskMemberSearch(nickname: nickname);
      List<UserProfileModel> users = [];
      for (int i = 0; i < response.length; i++) {
        users.add(UserProfileModel.fromJson(response[i]));
      }
      return users;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteTaskComment({required String taskId}) async {
    try {
      await _taskDataSource.deleteTaskComment(taskId: taskId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> uploadTaskCommentAttachment({
    required File file,
    required String taskId,
    required bool isFile,
  }) async {
    try {
      await _taskDataSource.uploadTaskCommentAttachment(
        file: file,
        taskId: taskId,
        isFile: isFile,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
