import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class AddEditTaskController extends BaseTasksController with AccessTokenMixin {
  final UserProfileRepository _userRepository;
  final ProjectRepository _projectRepository;
  AddEditTaskController({
    required ProjectRepository projectRepository,
    required UserProfileRepository userRepository,
    required super.taskValidator,
    required super.projectController,
    required super.attachmentsProvider,
    required super.secureStorage,
    required super.panelProvider,
    required super.memberProvider,
    required super.taskRepository,
  })  : _userRepository = userRepository,
        _projectRepository = projectRepository;

  bool isEditMode = false;

  void getEditData({
    required String? assignedto,
    required String projectId,
    required List<UserProfileModel> members,
  }) async {
    // fetch user
    final id = await secureStorage.getUserData(type: StorageDataType.id) ?? '';
    final user = await _userRepository.fetchUser(
      id: assignedto ?? id,
    );

    // picked project
    pickedUser.value = user;
    userTextController.text = user.username;
    pickedUser.notifyListeners();

    final project =
        await _projectRepository.fetchOneProject(projectId: projectId);
    pickedProject.value = project;
    pickedProject.notifyListeners();
    // pick members
    projectTextController.text = project.title;
    memberProvider.fillMembers(members);
  }

  Future<void> createTask(BuildContext context) async {
    try {
      log('is picke project ${pickedProject.value?.title}');
      changeSubmitButton(false);
      if (await taskValidator.tryValidate(
        pickedProject: pickedProject.value,
        context: context,
        formKey: formKey,
      )) {
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
              dueDate: (calendarController.value.day == DateTime.now().day ||
                      calendarController.value.day < DateTime.now().day)
                  ? null
                  : DateFormat("yyyy-MM-ddThh:mm:ss.ssssss")
                      .format(calendarController.value),
              members: members,
            );
        attachmentsProvider.hasAttachments()
            ? await attachmentsProvider.uploadTaskAttachment(taskId: model.id)
            : null;

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
  }

  Future<void> updateTask({
    required String taskId,
    required BuildContext context,
  }) async {
    try {
      changeSubmitButton(false);

      if (await taskValidator.tryValidate(
          context: context,
          formKey: formKey,
          pickedProject: pickedProject.value!)) {
        List<String> members = [];
        if (super.memberProvider.taskMembers.value.isNotEmpty) {
          for (var element in super.memberProvider.taskMembers.value) {
            members.add(element.id);
          }
        }
        final model = await super.taskRepository.updateTask(
              taskId: taskId,
              title: titleTextController.text,
              description: descriptionTextController.text,
              assignedTo: pickedUser.value?.id,
              projectId: pickedProject.value!.id,
              members: members,
              dueDate: (calendarController.value.day == DateTime.now().day ||
                      calendarController.value.day < DateTime.now().day)
                  ? null
                  : DateFormat("yyyy-MM-ddThh:mm:ss.ssssss")
                      .format(calendarController.value),
            );
        attachmentsProvider.hasAttachments()
            ? await attachmentsProvider.uploadTaskAttachment(taskId: model.id)
            : null;

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
  }

  Map<String, String>? imageHeader;

  void getAccessToken() async =>
      imageHeader = await getAccessHeader(secureStorage);
}
