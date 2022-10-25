import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

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
  })  : _userRepository = userRepository,
        _projectRepository = projectRepository;

  bool isEditMode = false;
  String taskId = '';

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
    try {
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
        log('created time ${model.dueDate}');
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

  Future<void> updateTask(BuildContext context) async {
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
              isCompleted: false,
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

  Future<void> getAccessToken() async =>
      imageHeader = await getAccessHeader(secureStorage);
}
