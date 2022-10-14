import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/model/task_models/comment_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/member_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_validator.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

abstract class BaseTasksController extends ChangeNotifier {
  final ProjectController projectController;
  final AttachmentsProvider attachmentsProvider;
  final TaskValidator taskValidator;
  final PanelProvider panelProvider;
  final MemberProvider memberProvider;
  final TaskRepository taskRepository;
  final SecureStorageSource secureStorage;
  BaseTasksController({
    required this.taskValidator,
    required this.projectController,
    required this.attachmentsProvider,
    required this.secureStorage,
    required this.panelProvider,
    required this.memberProvider,
    required this.taskRepository,
  });

  final formKey = GlobalKey<FormState>();

  final AdvancedCalendarController calendarController =
      AdvancedCalendarController.today();

// TODO remove text
  final userTextController = TextEditingController(text: 'Assignee');
  final projectTextController = TextEditingController(text: 'Project');

  final memberTextController = TextEditingController();
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  final isActiveSubmitButton = ValueNotifier<bool>(true);
  void changeSubmitButton(bool newValue) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }

  final pickedProject = ValueNotifier<ProjectModel?>(null);

// TRANSLATE
  bool isPickedProject(BuildContext context) {
    return pickedProject.value != null
        ? true
        : throw MessageService.displaySnackbar(
            context: context,
            message: 'Project is not picked',
          );
  }

  void pickProject({
    required ProjectModel newProject,
    required BuildContext context,
  }) {
    pickedProject.value = newProject;
    projectTextController.text = pickedProject.value!.title;
    pickedProject.notifyListeners();
    FocusScope.of(context).unfocus();
    panelProvider.changePanelStatus(newStatus: PanelStatus.hide);
  }

  final pickedUser = ValueNotifier<UserProfileModel?>(null);

  void pickUser({
    required UserProfileModel newUser,
    required BuildContext context,
  }) {
    pickedUser.value = newUser;
    userTextController.text = pickedUser.value!.username;
    pickedUser.notifyListeners();
    FocusScope.of(context).unfocus();
    panelProvider.changePanelStatus(newStatus: PanelStatus.hide);
  }

  Future<List<UserProfileModel>> taskMemberSearch(
          {required String userName}) async =>
      await taskRepository.taskMemberSearch(nickname: userName);
}

mixin CommentsMixin {
  final taskRepository = TaskRepositoryImpl();

  Future<List<CommentModel>> fetchComments({required String taskId}) async {
    return await taskRepository.fetchTaskComments(taskId: taskId);
  }

  Future<void> createTaskComment({
    required String content,
    required String taskId,
  }) async {
    return await taskRepository.createTaskComment(
      taskId: taskId,
      content: content,
    );
  }
}
