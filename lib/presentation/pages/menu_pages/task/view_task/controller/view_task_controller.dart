import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ViewTaskController extends BaseTasksController {
  final UserProfileRepository _userRepository;
  final ProjectRepository _projectRepository;
  ViewTaskController({
    required UserProfileRepository userRepository,
    required ProjectRepository projectRepository,
    required super.taskValidator,
    required super.projectController,
    required super.attachmentsProvider,
    required super.secureStorage,
    required super.panelProvider,
    required super.memberProvider,
    required super.taskRepository,
  })  : _userRepository = userRepository,
        _projectRepository = projectRepository;

  bool isShowComments = false;

  final commentController = TextEditingController();

  UserProfileModel? user;
  ProjectModel? project;
  
  Future<void> fetchUser(String? assignedTo) async {
    final id =  await secureStorage.getUserData(type: StorageDataType.id) ??'';
    user = await _userRepository.fetchUser(
      id: assignedTo ?? id,
    );
  }

  Future<void> fetchProject(String projectId) async {
    project = await _projectRepository.fetchOneProject(projectId: projectId);
  }
}
