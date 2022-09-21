import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

abstract class TaskDataSource {
  Future<void> createTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
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
          TaskScheme.attachments: null,
          TaskScheme.createdAt: DateTime.now().toUtc().toIso8601String(),
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('createTask ${response.statusMessage}');
      log('createTask ${response.statusCode}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data[TaskScheme.data] as Map<String, dynamic>)
          : throw Failure(
              'Error: ${response.data[TaskScheme.data][TaskScheme.message]}');
    } catch (e) {
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
          "type": isFile == true ? 'file' : 'image',
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
      // FAKE
      // final response = await _network.get(
      //   path: '$_taskMemberSearch?query=$nickname',
      //   options: await _network.getLocalRequestOptions(),
      // );
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {
          "data": [
            {
              "id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
              "email": "andrei.kastsiuk@cogniteq.com",
              "username": "andreikastsiuk",
              "avatar_url":
                  "https://todolist.dev2.cogniteq.com/api/v1/users-avatar/76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
              "created_at": "2022-07-12T14:46:44.750598"
            },
            {
              "id": "66e5270a-7c8d-4fd8-ac7d-1e74745f1798",
              "email": "andrei.kastsiuk1@cogniteq.com",
              "username": "andreikastsiuk",
              "avatar_url":
                  "https://todolist.dev2.cogniteq.com/api/v1/users-avatar/66e5270a-7c8d-4fd8-ac7d-1e74745f1798",
              "created_at": "2022-07-13T08:38:15.119284"
            },
            {
              "id": "d0712893-00b7-4658-8227-2957ef11cad0",
              "email": "andrei.kastsiuk2@cogniteq.com",
              "username": "andreikastsiuk",
              "avatar_url":
                  "https://todolist.dev2.cogniteq.com/api/v1/users-avatar/d0712893-00b7-4658-8227-2957ef11cad0",
              "created_at": "2022-07-13T09:16:30.841251"
            },
            {
              "id": "d96e5ab4-dc94-4388-8fb4-b9c6153714dd",
              "email": "andrei.kastsiuk3@cogniteq.com",
              "username": "andreikastsiuk",
              "avatar_url":
                  "https://todolist.dev2.cogniteq.com/api/v1/users-avatar/d96e5ab4-dc94-4388-8fb4-b9c6153714dd",
              "created_at": "2022-07-13T09:16:33.113941"
            },
            {
              "id": "4a6af995-3111-4dc6-ab09-a1abc02e7892",
              "email": "andrei.kastsiuk5@cogniteq.com",
              "username": "andreikastsiuk",
              "avatar_url":
                  "https://todolist.dev2.cogniteq.com/api/v1/users-avatar/4a6af995-3111-4dc6-ab09-a1abc02e7892",
              "created_at": "2022-07-13T09:16:35.924425"
            }
          ]
        },
        statusCode: 200,
      );
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
