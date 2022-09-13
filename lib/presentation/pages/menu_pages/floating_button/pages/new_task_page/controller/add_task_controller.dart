import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/repository/comment_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

enum InputFieldStatus {
  showUserPanel,
  showProjectPanel,
  hide,
}

class AddTaskController extends ChangeNotifier {
  UserProfileRepositoryImpl userProfileRepository;
  TaskRepositoryImpl taskRepository;
  TasksMembersRepositoryImpl tasksMembers;

  final formKey = GlobalKey<FormState>();

  AddTaskController({
    required this.userProfileRepository,
    required this.taskRepository,
    required this.tasksMembers,
  });

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

  final files = ValueNotifier<List<PlatformFile>>([]);

  final pickedUser = ValueNotifier<UserProfileModel>(
    UserProfileModel(avatarUrl: '', createdAt: '', username: '', id: ''),
  );

  void pickUser({
    required UserProfileModel newUser,
    required BuildContext context,
  }) {
    pickedUser.value = newUser;
    userTextController.text = pickedUser.value.username;
    pickedUser.notifyListeners();
    log(pickedUser.value.toString());
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

  final pickedTime = ValueNotifier<DateTime?>(null);
  void pickTime({required DateTime newTime}) {
    pickedTime.value = newTime;
    pickedTime.notifyListeners();
  }

  Future<void> pickFile({required BuildContext context}) async {
    const int maxSize = 26214400;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result!.files.first.size >= maxSize) {
        result.files.clear();
        MessageService.displaySnackbar(
          message: 'You cant put huge file',
          context: context,
        );
      } else {
        PlatformFile file = result.files.first;
        files.value.add(file);
      }
      log(files.value[0].path.toString());
      files.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  late String userName = '', image = '';
  Future<List<String>> fetchCommentInfo() async {
    try {
      // TODO fix it
      // image = await userProfileRepository.fetchAvatarFromStorage();
      // userName = await userProfileRepository.fetchUserName();
      return [image, userName];
    } catch (e) {
      throw Failure(e.toString());
    }
  }

// validation

  Future<void> validate({
    required BuildContext context,
    required String title,
    required String description,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        isClickedAddTask.value = false;
        isClickedAddTask.notifyListeners();
// TODo remove navigation
        await putTask(
          description: description,
          title: title,
        ).then((_) => NavigationService.navigateTo(
              context,
              Pages.tasks,
            ));

        isClickedAddTask.value = true;
        isClickedAddTask.notifyListeners();

        //  disposeAll();

      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> putTask({
    required String title,
    required String description,
  }) async {
    try {
      int userId = 0;
      // await userProfileRepository.fetchId();
      int projectId = 0;

      // await taskRepository.postTask(
      //   title: title,
      //   description: description,
      //   assignedTo: userId,
      //   projectId: projectId,
      //   dueDate: pickedTime.value!,
      // );
      //TODO fix it
      // int currentProjectId = await taskRepository.fetchTaskId(title: title);
      // // push attachment
      // for (int i = 0; i < files.value.length; i++) {
      //   await taskAttachment.putAttachment(
      //       url: files.value[i].name, taskId: currentProjectId);
      // }
      //
      // // task members
      // for (int i = 0; i < taskMembers.value.length; i++) {
      //   tasksMembers.putMember();
      // }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void disposeAll() {
    taskMembers.dispose();
    pickedUser.dispose();
    pickedProject.dispose();
    userTextController.dispose();
    projectTextController.dispose();
    isShowPickUserWidget.dispose();
    isShowProjectWidget.dispose();
    panelStatus.dispose();
    pickedTime.dispose();
    files.dispose();
    isClickedAddTask.dispose();
  }
}
