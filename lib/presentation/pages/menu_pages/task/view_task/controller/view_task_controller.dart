import 'package:flutter/cupertino.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
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

  Future<void> fetchDetailedUser(String ownerId) async {
    final id = await _secureStorage.getUserData(type: StorageDataType.id) ?? '';
    if (ownerId == 'null') {
      user = await _userRepository.fetchUser(id: id);
    } else {
      user = await _userRepository.fetchUser(id: ownerId);
    }
  }

  Future<void> fetchProject(String projectId) async {
    project = await _projectRepository.fetchOneProject(projectId: projectId);
  }

  Future<List<CommentModel>> fetchComments({required String taskId}) async {
    return await _taskRepository.fetchTaskComments(taskId: taskId);
  }

  final isActiveSubmitButton = ValueNotifier<bool>(true);
  void changeSubmitButton(bool newValue) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }

  Map<String, String>? imageHeader;

  void getAccessToken() async =>
      imageHeader = await getAccessHeader(_secureStorage);

  Future<CommentModel> createTaskComment({
    required String content,
    required String taskId,
  }) async {
    return await _taskRepository.createTaskComment(
      taskId: taskId,
      content: content,
    );
  }
}
