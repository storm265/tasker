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
    required DateTime? dueDate,
    List<Map<String, dynamic>>? attachments,
    List<String>? members,
  });

  Future<void> deleteTask({required String projectId});

  Future<void> updateTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
    List<String>? members,
  });

  Future<Map<String, dynamic>> fetchOneTask({required String projectId});

  Future<List<dynamic>> fetchProjectTasks({required String projectId});

  Future<List<dynamic>> fetchUserTasks({required String projectId});

  Future<List<dynamic>> fetchAssignedToTasks({required String projectId});

  Future<List<dynamic>> fetchParticipateInTasks({required String projectId});

  Future<void> uploadTaskAttachment({
    required String name,
    required File file,
    required String taskId,
    required bool isFile,
  });

  Future<void> createTaskComment({
    required String content,
    required String taskId,
  });

  Future<List<dynamic>> fetchTaskComments({required String taskId});

  Future<List<dynamic>> taskMemberSearch({required String nickname});

  Future<void> deleteTaskComment({required String taskId});

  Future<void> uploadTaskCommentAttachment({
    required File file,
    required String taskId,
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
    required DateTime? dueDate,
    List<Map<String, dynamic>>? attachments,
    List<String>? members,
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);

      final response = await _network.post(
        path: _tasks,
        data: {
          TaskScheme.title: title,
          TaskScheme.dueDate: dueDate?.toUtc().toIso8601String(),
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
      log('createTask  data : ${response.data}');
      log('createTask ${response.statusMessage}');
      log('createTask ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data[TaskScheme.data] as Map<String, dynamic>)
          : throw Failure(
              'Error: ${response.data[TaskScheme.data][TaskScheme.message]}');
    } catch (e, t) {
      log('create tasl error $t');
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> updateTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
    List<String>? members,
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.put(
        path: '$_tasks/$projectId',
        data: {
          TaskScheme.title: title,
          TaskScheme.dueDate: dueDate,
          TaskScheme.description: description,
          TaskScheme.assignedTo: assignedTo,
          TaskScheme.isCompleted: false,
          TaskScheme.projectId: projectId, // id of project (menu)
          TaskScheme.ownerId: ownerId,
          TaskScheme.members: members,
          TaskScheme.attachments: null,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('updateTask ${response.statusMessage}');
      log('updateTask ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data[TaskScheme.data] as Map<String, dynamic>)
          : throw Failure(
              'Error: ${response.data[TaskScheme.data][TaskScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteTask({required String projectId}) async {
    try {
      final response = await _network.delete(
        path: '$_tasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );

      log('deleteTask ${response.statusMessage}');
      log('deleteTask ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> fetchOneTask({required String projectId}) async {
    try {
      final response = await _network.get(
        path: '$_tasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );

      log('fetchOneTask ${response.statusMessage}');
      log('fetchOneTask ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![TaskScheme.data] as Map<String, dynamic>)
          : throw Failure('Error: Get fetchOneTask error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchProjectTasks(
      {required String projectId}) async {
    try {
      final response = await _network.get(
        path: '$_projectTasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );

      log('fetchProjectTasks ${response.statusMessage}');
      log('fetchProjectTasks ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![TaskScheme.data] as List<Map<String, dynamic>>)
          : throw Failure('Error: Get fetchProjectTasks error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchUserTasks({required String projectId}) async {
    try {
      final response = await _network.get(
        path: '$_userTasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );

      log('fetchUserTasks ${response.statusMessage}');
      log('fetchUserTasks ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![TaskScheme.data] as List<dynamic>)
          : throw Failure('Error: Get fetchUserTasks error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchAssignedToTasks(
      {required String projectId}) async {
    try {
      final response = await _network.get(
        path: '$_assignedToTasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );

      log('fetchAssignedToTasks ${response.statusMessage}');
      log('fetchAssignedToTasks ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![TaskScheme.data] as List<dynamic>)
          : throw Failure('Error: fetchAssignedToTask error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchParticipateInTasks(
      {required String projectId}) async {
    try {
      final response = await _network.get(
        path: '$_participateInTasks/$projectId',
        options: await _network.getLocalRequestOptions(),
      );

      log('fetchParticipateInTasks ${response.statusMessage}');
      log('fetchParticipateInTasks ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![TaskScheme.data] as List<dynamic>)
          : throw Failure('Error: fetchAssignedToTask error');
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
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  //   @override
  // Future<List<dynamic>> downloadTaskAttachment(
  //     {required String attachmentsId}) async {
  //   try {
  //     final response = await _network.get(
  //       path: '$_tasksAttachments/$attachmentsId',
  //       options: await _network.getLocalRequestOptions(),
  //     );
  //     log('downloadTaskAttachment ${response.statusMessage}');
  //     log('downloadTaskAttachment ${response.statusCode}');
  //     return NetworkErrorService.isSuccessful(response)
  //         ? (response.data![TaskScheme.data] as List<dynamic>)
  //         : throw Failure('Error: fetchAssignedToTask error');
  //   } catch (e) {
  //     throw Failure(e.toString());
  //   }
  // }

// maybe should return model
  @override
  Future<void> createTaskComment({
    required String content,
    required String taskId,
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);

      final response = await _network.post(
        path: _comments,
        data: {
          TaskScheme.content: content,
          TaskScheme.taskId: taskId,
          TaskScheme.ownerId: ownerId,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );

      log('createTaskComment ${response.statusMessage}');
      log('createTaskComment ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchTaskComments({required String taskId}) async {
    try {
      final response = await _network.get(
        path: '$_tasksComments/$taskId',
        options: await _network.getLocalRequestOptions(),
      );

      log('fetchTaskComments ${response.statusMessage}');
      log('fetchTaskComments ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![TaskScheme.data] as List<dynamic>)
          : throw Failure('Error: Get fetchTaskComments error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> taskMemberSearch({required String nickname}) async {
    try {
      final response = await _network.get(
        path: '$_taskMemberSearch?query=$nickname',
        options: await _network.getLocalRequestOptions(),
      );
      log('search ${response.statusCode}');
      log('search ${response.statusMessage}');
      log('search ${response.data}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![TaskScheme.data] as List<dynamic>)
          : throw Failure('Error: get taskMemberSearch error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteTaskComment({required String taskId}) async {
    try {
      final response = await _network.delete(
        path: '$_comments/$taskId',
        options: await _network.getLocalRequestOptions(),
      );

      log('deleteTaskComment ${response.statusMessage}');
      log('deleteTaskComment ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> uploadTaskCommentAttachment({
    required File file,
    required String taskId,
    required bool isFile,
  }) async {
    try {
      String fileName = file.path.split('/').last;

      var formData = FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
          "type": isFile == true ? 'file' : 'image',
          TaskScheme.commentId: taskId,
        },
      );
      final response = await _network.post(
        path: _tasksAttachments,
        formData: formData,
        isFormData: true,
        options: await _network.getLocalRequestOptions(),
      );

      log('uploadTaskCommentAttachment ${response.statusMessage}');
      log('uploadTaskCommentAttachment ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
