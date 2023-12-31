import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo2/data/data_source/task/task_data_source.dart';
import 'package:todo2/schemas/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';

class TaskDataSourceImpl implements TaskDataSource {
  TaskDataSourceImpl({
    required NetworkSource network,
    required SecureStorageSource secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

  final _tasks = '/tasks';

  final _projectTasks = '/project-tasks';

  final _userTasks = '/user-tasks';

  final _assignedToTasks = '/assigned-tasks';

  final _participateInTasks = '/participate-in-tasks';

  final _tasksAttachments = '/tasks-attachments';

  final _comments = '/comments';

  final _tasksComments = '/tasks-comments';

  final _taskMemberSearch = '/task-members-search';

  final _commentsAttachments = '/comments-attachments';

  final NetworkSource _network;

  final SecureStorageSource _secureStorage;

  @override
  Future<Map<String, dynamic>> createTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String? dueDate,
    List<Map<String, dynamic>>? attachments,
    List<String>? members,
  }) async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);

    final response = await _network.post(
      path: _tasks,
      data: {
        TaskScheme.title: title,
        TaskScheme.dueDate: dueDate,
        TaskScheme.description: description,
        TaskScheme.assignedTo: assignedTo,
        TaskScheme.isCompleted: false,
        TaskScheme.projectId: projectId,
        TaskScheme.ownerId: ownerId,
        TaskScheme.members: members,
        TaskScheme.attachments: attachments,
      },
      options: await _network.getLocalRequestOptions(useContentType: true),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data[TaskScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[TaskScheme.data][TaskScheme.message]}');
  }

  @override
  Future<Map<String, dynamic>> updateTask({
    required String title,
    required String description,
    required String? assignedTo,
    required String projectId,
    required String taskId,
    required String? dueDate,
    required bool isCompleted,
    List<Map<String, dynamic>>? attachments,
    List<String>? members,
  }) async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);
    final response = await _network.put(
      path: '$_tasks/$taskId',
      data: {
        TaskScheme.title: title,
        TaskScheme.dueDate: dueDate,
        TaskScheme.description: description,
        TaskScheme.assignedTo: assignedTo,
        TaskScheme.isCompleted: isCompleted,
        TaskScheme.projectId: projectId,
        TaskScheme.ownerId: ownerId,
        TaskScheme.members: members,
        TaskScheme.attachments: attachments,
      },
      options: await _network.getLocalRequestOptions(useContentType: true),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data[TaskScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[TaskScheme.data][TaskScheme.message]}');
  }

  @override
  Future<void> deleteTask({required String projectId}) async =>
      await _network.delete(
        path: '$_tasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );

  @override
  Future<Map<String, dynamic>> fetchOneTask({required String projectId}) async {
    final response = await _network.get(
      path: '$_tasks/$projectId',
      options: await _network.getLocalRequestOptions(),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data![TaskScheme.data] as Map<String, dynamic>)
        : throw Failure('Error: Get fetchOneTask error');
  }

  @override
  Future<List<dynamic>> fetchProjectTasks({required String projectId}) async {
    final response = await _network.get(
      path: '$_projectTasks/$projectId',
      options: await _network.getLocalRequestOptions(),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data![TaskScheme.data] as List<dynamic>)
        : throw Failure('Error: Get fetchProjectTasks error');
  }

  @override
  Future<List<dynamic>> fetchUserTasks() async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);
    final response = await _network.get(
      path: '$_userTasks/$ownerId',
      options: await _network.getLocalRequestOptions(),
    );

    if (NetworkErrorService.isSuccessful(response)) {
      return (response.data![TaskScheme.data] as List<dynamic>);
    } else {
      return [];
    }
  }

  @override
  Future<List<dynamic>> fetchAssignedToTasks() async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);
    final response = await _network.get(
      path: '$_assignedToTasks/$ownerId',
      options: await _network.getLocalRequestOptions(),
    );

    if (NetworkErrorService.isSuccessful(response)) {
      return (response.data![TaskScheme.data] as List<dynamic>);
    } else {
      return [];
    }
  }

  @override
  Future<List<dynamic>> fetchParticipateInTasks() async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);

    final response = await _network.get(
      path: '$_participateInTasks/$ownerId',
      options: await _network.getLocalRequestOptions(),
    );

    if (NetworkErrorService.isSuccessful(response)) {
      return (response.data![TaskScheme.data] as List<dynamic>);
    } else {
      return [];
    }
  }

  @override
  Future<void> uploadTaskAttachment({
    required String name,
    required File file,
    required String taskId,
    required bool isFile,
  }) async {
    String fileName = file.path.split('/').last;

    var formData = FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        "type": isFile == true ? 'FILE' : 'IMAGE',
        TaskScheme.taskId: taskId,
      },
    );
    await _network.post(
      path: _tasksAttachments,
      formData: formData,
      isFormData: true,
      options: await _network.getLocalRequestOptions(),
    );
  }

  @override
  Future<Map<String, dynamic>> createTaskComment({
    required String content,
    required String taskId,
  }) async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);

    final response = await _network.post(
      path: _comments,
      data: {
        TaskScheme.content: content,
        TaskScheme.taskId: taskId,
        TaskScheme.ownerId: ownerId,
      },
      options: await _network.getLocalRequestOptions(useContentType: true),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data![TaskScheme.data] as Map<String, dynamic>)
        : throw Failure('Error: createTaskComment error');
  }

  @override
  Future<List<dynamic>> fetchTaskComments({required String taskId}) async {
    final response = await _network.get(
      path: '$_tasksComments/$taskId',
      options: await _network.getLocalRequestOptions(),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data![TaskScheme.data] as List<dynamic>)
        : throw Failure('Error: Get fetchTaskComments error');
  }

  @override
  Future<List<dynamic>> taskMemberSearch({required String nickname}) async {
    final response = await _network.get(
      path: '$_taskMemberSearch?query=$nickname',
      options: await _network.getLocalRequestOptions(),
    );
    return NetworkErrorService.isSuccessful(response)
        ? (response.data![TaskScheme.data] as List<dynamic>)
        : throw Failure('Error: get taskMemberSearch error');
  }

  @override
  Future<void> deleteTaskComment({required String taskId}) async =>
      await _network.delete(
        path: '$_comments/$taskId',
        options: await _network.getLocalRequestOptions(),
      );

  @override
  Future<void> uploadTaskCommentAttachment({
    required File file,
    required String commentId,
    required bool isFile,
  }) async {
    String fileName = file.path.split('/').last;

    var formData = FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        "type": isFile == true ? 'FILE' : 'IMAGE',
        TaskScheme.commentId: commentId,
      },
    );

    await _network.post(
      path: _commentsAttachments,
      formData: formData,
      isFormData: true,
      options: await _network.getLocalRequestOptions(),
    );
  }
}
