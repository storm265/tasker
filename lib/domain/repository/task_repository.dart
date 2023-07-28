import 'dart:io';

import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/domain/model/task_models/comment_model.dart';
import 'package:todo2/domain/model/task_models/task_model.dart';

abstract class TaskRepository {
  
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

  Future<List<TaskModel>> fetchProjectTasks({required String projectId});

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
