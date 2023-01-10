
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/secure_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/connection_checker.dart';
import 'package:todo2/services/secure_storage_service.dart';

class AddEditTaskController extends BaseTasks
    with SecureMixin, ConnectionCheckerMixin {
  final UserProfileRepository _userRepository;
  final ProjectRepository _projectRepository;
  AddEditTaskController({
    required ProjectRepository projectRepository,
    required UserProfileRepository userRepository,
    required super.taskValidator,
    required super.attachmentsProvider,
    required super.secureStorage,
    required super.panelProvider,
    required super.memberProvider,
  })  : _userRepository = userRepository,
        _projectRepository = projectRepository;

  bool isEditMode = false;
  String taskId = '';
  String? ownerId;

  void getEditData({
    required String id,
    required String ownerId,
    required DateTime dueDate,
    required DateTime createdAt,
    required String? assignedTo,
    required String projectId,
    required String title,
    required String description,
    required List<UserProfileModel> members,
  }) async {
    taskId = id;

    final user = assignedTo == null
        ? UserProfileModel(
            id: ownerId,
            username: '',
            email: '',
            avatarUrl: '',
            createdAt: createdAt)
        : await _userRepository.fetchUser(
            id: assignedTo,
          );

    pickedUser.value = user;
    userTextController.text = user.username;
    pickedUser.notifyListeners();

    final project =
        await _projectRepository.fetchOneProject(projectId: projectId);
    pickedProject.value = project;
    pickedProject.notifyListeners();

    projectTextController.text = project.title;

    titleTextController.text = title;

    descriptionTextController.text = description;

    calendarController.value = dueDate;

    memberProvider.fillMembers(members);
  }

  Future<void> createTask(BuildContext context) async {
    changeSubmitButton(false);
    if (await isConnected()) {
      try {
        if (await taskValidator.tryValidate(
            pickedProject: pickedProject.value,
            context: context,
            formKey: formKey,
            pickedDate: calendarController.value)) {
          List<String> members = [];
          if (super.memberProvider.taskMembers.value.isNotEmpty) {
            for (var element in super.memberProvider.taskMembers.value) {
              members.add(element.id);
            }
          }

          final model = await super.taskRepository.createTask(
                title: titleTextController.text,
                description: descriptionTextController.text,
                assignedTo: pickedUser.value?.id,
                projectId: pickedProject.value?.id ?? '',
                dueDate: DateFormat("yyyy-MM-ddThh:mm:ss.ssssss")
                    .format(calendarController.value),
                members: members,
              );

          attachmentsProvider.hasAttachments()
              ? await attachmentsProvider.uploadTaskAttachment(taskId: model.id)
              : null;
          if (model.id.isNotEmpty) {
            MessageService.displaySnackbar(
              context: context,
              message: LocaleKeys.created.tr(),
            );
          }
          Future.delayed(
            Duration.zero,
            () => NavigationService.navigateTo(
              context,
              Pages.navigationReplacement,
            ),
          );
        }
      } finally {
        changeSubmitButton(true);
      }
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
      changeSubmitButton(true);
    }
  }

  Future<void> updateTask(BuildContext context) async {
    changeSubmitButton(false);
    if (await isConnected()) {
      try {
        if (await taskValidator.tryValidate(
            context: context,
            formKey: formKey,
            pickedProject: pickedProject.value,
            pickedDate: calendarController.value)) {
          List<String> members = [];
          if (super.memberProvider.taskMembers.value.isNotEmpty) {
            for (var element in super.memberProvider.taskMembers.value) {
              members.add(element.id);
            }
          }
          final model = await super.taskRepository.updateTask(
                isCompleted: false,
                taskId: taskId,
                title: titleTextController.text,
                description: descriptionTextController.text,
                assignedTo: pickedUser.value?.id,
                projectId: pickedProject.value!.id,
                members: members,
                dueDate: DateFormat("yyyy-MM-ddThh:mm:ss.ssssss")
                    .format(calendarController.value),
              );
          attachmentsProvider.hasAttachments()
              ? await attachmentsProvider.uploadTaskAttachment(taskId: model.id)
              : null;
          if (model.id.isNotEmpty) {
            MessageService.displaySnackbar(
              context: context,
              message: LocaleKeys.created.tr(),
            );
          }
          Future.delayed(
            Duration.zero,
            () => NavigationService.navigateTo(
              context,
              Pages.tasks,
            ),
          );
        }
      } finally {
        changeSubmitButton(true);
      }
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
      changeSubmitButton(true);
    }
  }

  Map<String, String>? imageHeader;

  Future<void> getAccessToken() async =>
      imageHeader = await getAccessHeader(secureStorage);

  Future<void> getOwnerId() async {
    ownerId = await secureStorage.getUserData(type: StorageDataType.id) ?? '';
  }

  Future<List<ProjectModel>> searchProject({required String title}) async {
    final projects = await _projectRepository.searchProject(title: title);
    final ownerProjects =
        projects.where((element) => element.ownerId == ownerId).toList();
    return ownerProjects;
  }
}
