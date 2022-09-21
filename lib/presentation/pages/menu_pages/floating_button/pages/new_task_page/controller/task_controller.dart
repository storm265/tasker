import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/comment_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

enum InputFieldStatus {
  showUserPanel,
  showProjectPanel,
  hide,
}

class AddTaskController extends ChangeNotifier {
  Future<void> createTask({
    required String? assignedTo,
    required String projectId,
    List<String>? members,
  }) async {
    try {
      final model = await _taskRepository.createTask(
        title: titleController.text,
        description: descriptionController.text,
        assignedTo: assignedTo,
        projectId: projectId,
        dueDate: pickedDate.value,
      );
      taskList.value.add(model);
      taskList.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteTask({required String projectId}) async {
    try {
      await _taskRepository.deleteTask(projectId: projectId);
      taskList.value.removeWhere((element) => element.id == projectId);
      taskList.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateTask({
    required String title,
    required String description,
    required String assignedTo,
    required String projectId,
    required DateTime dueDate,
    List<String>? members,
  }) async {
    try {
      final updatedModel = await _taskRepository.updateTask(
        title: title,
        description: description,
        assignedTo: assignedTo,
        projectId: projectId,
        dueDate: dueDate,
      );
      for (var i = 0; i < taskList.value.length; i++) {
        if (taskList.value[i].id == updatedModel.id) {
          taskList.value[i] = updatedModel;
          break;
        }
      }
      taskList.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<UserProfileModel>> taskMemberSearch(
          {required String nickname}) async =>
      await _taskRepository.taskMemberSearch(nickname: nickname);

  final _taskRepository = TaskRepositoryImpl();
  final userProfileRepository = UserProfileRepositoryImpl(
    userProfileDataSource: UserProfileDataSourceImpl(
      secureStorageService: SecureStorageSource(),
      network: NetworkSource(),
    ),
  );

  final taskList = ValueNotifier<List<TaskModel>>([]);
  final projectController = ProjectController();

  final pickedDate = AdvancedCalendarController.today();
  final calendarController = AdvancedCalendarController.today();

  final List<DateTime> events = [
    DateTime.utc(2022, 09, 19, 12),
    DateTime.utc(2022, 09, 20, 12),
    DateTime.utc(2022, 09, 21, 12),
    DateTime.utc(2022, 09, 22, 12),
    DateTime.utc(2022, 09, 23, 12),
  ];

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final taskMembers = ValueNotifier<List<UserProfileModel>>([]);

  void addMember({required UserProfileModel chipTitle}) {
    taskMembers.value.add(chipTitle);
    taskMembers.notifyListeners();
  }

  void removeMember({required int index}) {
    taskMembers.value.removeAt(index);
    taskMembers.notifyListeners();
  }

  void clearMemberList() {
    taskMembers.value.clear();
    taskMembers.notifyListeners();
  }

  final userTextController = TextEditingController(text: 'Assignee');
  final projectTextController = TextEditingController(text: 'Project');

  final attachments = ValueNotifier<List<PlatformFile>>([]);
  
  void addAttachment({required PlatformFile attachment}){
    attachments.value.add(attachment);
    attachments.notifyListeners();
  }
    void removeAttachment(int index){
    attachments.value.removeAt(index);
    attachments.notifyListeners();
  }

  

  final pickedUser = ValueNotifier<UserProfileModel>(
    UserProfileModel(
      avatarUrl: '',
      createdAt: '',
      username: '',
      id: '',
      email: '',
    ),
  );

  void pickUser({
    required UserProfileModel newUser,
    required BuildContext context,
  }) {
    pickedUser.value = newUser;
    userTextController.text = pickedUser.value.username;
    pickedUser.notifyListeners();
    FocusScope.of(context).unfocus();
    changePanelStatus(newStatus: InputFieldStatus.hide);
  }

  final pickedProject = ValueNotifier<ProjectModel>(
    ProjectModel(
      id: '',
      color: Colors.red,
      createdAt: DateTime.now(),
      title: '',
      ownerId: '',
    ),
  );

  void pickProject({
    required ProjectModel newProject,
    required BuildContext context,
  }) {
    pickedProject.value = newProject;
    projectTextController.text = pickedProject.value.title;
    pickedProject.notifyListeners();
    log(pickedProject.value.toString());
    FocusScope.of(context).unfocus();
    changePanelStatus(newStatus: InputFieldStatus.hide);
  }

  final isClickedAddTask = ValueNotifier<bool>(true);

  final isShowPickUserWidget = ValueNotifier(false);

  final isShowProjectWidget = ValueNotifier(false);

  final panelStatus = ValueNotifier<InputFieldStatus>(InputFieldStatus.hide);

  void changePanelStatus({required InputFieldStatus newStatus}) {
    panelStatus.value = newStatus;
    panelStatus.notifyListeners();
  }

// validation

  Future<void> tryValidate({required BuildContext context}) async {
    try {
      if (formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();
        isClickedAddTask.value = false;
        isClickedAddTask.notifyListeners();
        // await createTask(

        // ).then((_) => NavigationService.navigateTo(
        //       context,
        //       Pages.tasks,
        //     ));
        isClickedAddTask.value = true;
        isClickedAddTask.notifyListeners();
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
