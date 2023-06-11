
import 'dart:io';

abstract class TaskDataSource {
  Future<Map<String, dynamic>> createTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String? dueDate,
    List<Map<String, dynamic>>? attachments,
    List<String>? members,
  });

  Future<void> deleteTask({required String projectId});

  Future<Map<String, dynamic>> updateTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String taskId,
    required String? dueDate,
    required bool isCompleted,
    List<String>? members,
  });

  Future<Map<String, dynamic>> fetchOneTask({required String projectId});

  Future<List<dynamic>> fetchProjectTasks({required String projectId});

  Future<List<dynamic>> fetchUserTasks();

  Future<List<dynamic>> fetchAssignedToTasks();

  Future<List<dynamic>> fetchParticipateInTasks();

  Future<void> uploadTaskAttachment({
    required String name,
    required File file,
    required String taskId,
    required bool isFile,
  });

  Future<Map<String, dynamic>> createTaskComment({
    required String content,
    required String taskId,
  });

  Future<List<dynamic>> fetchTaskComments({required String taskId});

  Future<List<dynamic>> taskMemberSearch({required String nickname});

  Future<void> deleteTaskComment({required String taskId});

  Future<void> uploadTaskCommentAttachment({
    required File file,
    required String commentId,
    required bool isFile,
  });
}
