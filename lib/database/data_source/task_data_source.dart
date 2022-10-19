import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

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

  Future<void> updateTask({
    required String title,
    required String description,
    required String assignedTo,
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

class TaskDataSourceImpl implements TaskDataSource {
  final _tasks = '/tasks';

  final _projectTasks = '/project-tasks';

  final _userTasks = '/user-tasks';

  final _assignedToTasks = '/asigned-tasks';

  final _participateInTasks = '/participate-in-tasks';

  final _tasksAttachments = '/tasks-attachments';

  final _comments = '/comments';

  final _tasksComments = '/tasks-comments';

  final _taskMemberSearch = '/task-members-search';

  final _commentsAttachments = '/comments-attachments';

  final NetworkSource _network;

  final SecureStorageSource _secureStorage;

  TaskDataSourceImpl({
    required NetworkSource network,
    required SecureStorageSource secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

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
    log('due data $dueDate');
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
    log('data ${response.data}');
    log('createTask ${response.statusMessage}');
    log('createTask ${response.statusCode}');
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
    log('updateTask ${response.data}');
    log('updateTask ${response.statusMessage}');
    log('updateTask ${response.statusCode}');
    return NetworkErrorService.isSuccessful(response)
        ? (response.data[TaskScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[TaskScheme.data][TaskScheme.message]}');
  }

  @override
  Future<void> deleteTask({required String projectId}) async {
    final response = await _network.delete(
      path: '$_tasks/$projectId',
      options: await _network.getLocalRequestOptions(),
    );
    log('response ${response.data}');
    log('deleteTask ${response.statusMessage}');
    log('deleteTask ${response.statusCode}');
  }

  @override
  Future<Map<String, dynamic>> fetchOneTask({required String projectId}) async {
    final response = await _network.get(
      path: '$_tasks/$projectId',
      options: await _network.getLocalRequestOptions(),
    );

    log('fetchOneTask ${response.statusMessage}');
    log('fetchOneTask ${response.statusCode}');
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
    final response = await _network.post(
      path: _tasksAttachments,
      formData: formData,
      isFormData: true,
      options: await _network.getLocalRequestOptions(),
    );

    log('uploadTaskAttachment ${response.statusMessage}');
    log('uploadTaskAttachment ${response.statusCode}');
  }

  //   @override
  // Future<List<dynamic>> downloadTaskAttachment(
  //     {required String attachmentsId}) async {

  //     final response = await _network.get(
  //       path: '$_tasksAttachments/$attachmentsId',
  //       options: await _network.getLocalRequestOptions(),
  //     );
  //     log('downloadTaskAttachment ${response.statusMessage}');
  //     log('downloadTaskAttachment ${response.statusCode}');
  //     return NetworkErrorService.isSuccessful(response)
  //         ? (response.data![TaskScheme.data] as List<dynamic>)
  //         : throw Failure('Error: fetchAssignedToTask error');

  // }

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
    log('createTaskComment ${response.statusCode}');
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
  Future<void> deleteTaskComment({required String taskId}) async {
    final response = await _network.delete(
      path: '$_comments/$taskId',
      options: await _network.getLocalRequestOptions(),
    );

    log('deleteTaskComment ${response.statusMessage}');
    log('deleteTaskComment ${response.statusCode}');
  }

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

    final response = await _network.post(
      path: _commentsAttachments,
      formData: formData,
      isFormData: true,
      options: await _network.getLocalRequestOptions(),
    );
    log('uploadTaskCommentAttachment ${response.data}');
    log('uploadTaskCommentAttachment ${response.statusMessage}');
    log('uploadTaskCommentAttachment ${response.statusCode}');
  }
}
