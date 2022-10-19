import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ViewTaskController extends ChangeNotifier with AccessTokenMixin {
  final UserProfileRepository _userRepository;
  final AttachmentsProvider attachmentsProvider;
  final SecureStorageSource _secureStorage;
  final ProjectRepository _projectRepository;
  final TaskRepository _taskRepository;
  ViewTaskController({
    required UserProfileRepository userRepository,
    required ProjectRepository projectRepository,
    required TaskRepository taskRepository,
    required this.attachmentsProvider,
    required SecureStorageSource secureStorage,
  })  : _userRepository = userRepository,
        _taskRepository = taskRepository,
        _projectRepository = projectRepository,
        _secureStorage = secureStorage;

  bool isShowComments = false;

  final commentController = TextEditingController();

  UserProfileModel? user;

  ProjectModel? project;

  final isActiveSubmitButton = ValueNotifier<bool>(true);

  Map<String, String>? imageHeader;

  Future<void> fetchInitialData(
      String projectId, String? assignedTo, VoidCallback callback) async {
    await Future.wait([
      getAccessToken(),
      fetchProject(projectId),
      fetchDetailedUser(assignedTo),
    ]).then((_) => callback());
  }

  Future<void> fetchDetailedUser(String? ownerId) async {
    if (ownerId != null) {
      String id =
          await _secureStorage.getUserData(type: StorageDataType.id) ?? '';
      user = await _userRepository.fetchUser(id: id);
    }
  }

  Future<TaskModel> updateTask(
    TaskModel model,
    BuildContext context,
  ) async {
    try {
      changeSubmitButton(false);
      List<String> members = [];
      if (model.members != null) {
        for (var i = 0; i < model.members!.length; i++) {
          members.add(model.members![i].id);
        }
      }

      final updatedModel = await _taskRepository
          .updateTask(
        taskId: model.id,
        title: model.title,
        isCompleted: true,
        description: model.description,
        assignedTo: model.assignedTo,
        projectId: model.projectId,
        members: members,
        dueDate: DateFormat("yyyy-MM-ddThh:mm:ss.ssssss").format(model.dueDate),
      )
          .then((_) {
        MessageService.displaySnackbar(
          context: context,
          message: LocaleKeys.updated.tr(),
        );
      });
      return updatedModel;
    } finally {
      changeSubmitButton(true);
    }
  }

  Future<void> fetchProject(String projectId) async {
    project = await _projectRepository.fetchOneProject(projectId: projectId);
  }

  Future<List<CommentModel>> fetchTaskComments({required String taskId}) async {
    return await _taskRepository.fetchTaskComments(taskId: taskId);
  }

  void changeSubmitButton(bool newValue) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }

  Future<void> getAccessToken() async =>
      imageHeader = await getAccessHeader(_secureStorage);

  Future<CommentModel> createTaskComment({required String taskId}) async {
    final model = await _taskRepository.createTaskComment(
      taskId: taskId,
      content: commentController.text,
    );
    commentController.clear();
    return model;
  }

  Future<void> uploadTaskCommentAttachment({required String commentId}) async {
    if (attachmentsProvider.attachments.value.isNotEmpty) {

      for (int i = 0; i < attachmentsProvider.attachments.value.length; i++) {
        await _taskRepository.uploadTaskCommentAttachment(
          file: File(attachmentsProvider.attachments.value[i].path ?? ''),
          taskId: commentId,
          isFile: !attachmentsProvider.fileProvider.isValidImageFormat(
            attachmentsProvider.attachments.value[i].extension ?? '',
          ),
        );
      }
    }
  }
}
