import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/database/model/task_models/task_attachments_model.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

enum InputFieldStatus {
  showUserPanel,
  showProjectPanel,
  hide,
}

class AddTaskController extends ChangeNotifier {
  static final AddTaskController _instance = AddTaskController._internal();

  factory AddTaskController() {
    return _instance;
  }

  AddTaskController._internal();

  final _taskRepository = TaskRepositoryImpl();
  final userProfileRepository = UserProfileRepositoryImpl(
    userProfileDataSource: UserProfileDataSourceImpl(
      secureStorageService: SecureStorageSource(),
      network: NetworkSource(),
    ),
  );

  final projectController = ProjectController();
  final fileController = FileController();

 final isTuneIconActive =ValueNotifier(true);
 void changeTuneIconStatus(bool  isMonthMode){
  isTuneIconActive.value = isMonthMode;
  isTuneIconActive.notifyListeners();
 }

  final isSubmitButtonClicked = ValueNotifier<bool>(true);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _assignedTo;
  String? _projectId;

  Future<List<UserProfileModel>> taskMemberSearch(
      {required String nickname}) async {
    final list = await _taskRepository.taskMemberSearch(nickname: nickname);
    for (var i = 0; i < list.length; i++) {
      log('list ${list[i].username}');
    }
    return list;
  }

  final pickedDate = AdvancedCalendarController.today();
  final calendarController = AdvancedCalendarController.today();

  bool isValidPickedDate(
    DateTime time,
    BuildContext context,
    bool useMessage,
  ) {
    if (time.day == DateTime.now().day || time.day < DateTime.now().day) {
      useMessage
          ? MessageService.displaySnackbar(
              context: context, message: 'You cant pick date before now!')
          : null;
      return false;
    } else {
      return true;
    }
  }

  final _secureStorage = SecureStorageSource();

  Map<String, String>? imageHeader;
  Future<void> getAccessHeader() async {
    final accessToken =
        await _secureStorage.getUserData(type: StorageDataType.accessToken) ??
            '';
    imageHeader = {'Authorization': 'Bearer $accessToken'};
  }

  final List<DateTime> events = [
    DateTime.utc(2022, 09, 19, 12),
    DateTime.utc(2022, 09, 20, 12),
    DateTime.utc(2022, 09, 21, 12),
    DateTime.utc(2022, 09, 22, 12),
    DateTime.utc(2022, 09, 23, 12),
  ];

  void clearData() {
    taskMembers.value.clear();
    taskMembers.notifyListeners();
    titleController.clear();
    descriptionController.clear();
    userTextController.clear();
    projectTextController.clear();
    attachments.value.clear();
  }

// MEMBERS

  final taskMembers = ValueNotifier<Set<UserProfileModel>>({});

  void addMember({required UserProfileModel userModel}) {
    taskMembers.value.add(userModel);
    taskMembers.notifyListeners();
  }

  void removeMember({required UserProfileModel model}) {
    taskMembers.value.removeWhere((element) => element.id == model.id);
    taskMembers.notifyListeners();
  }

  void clearMemberList() {
    taskMembers.value.clear();
    taskMembers.notifyListeners();
  }

  final userTextController = TextEditingController(text: 'Assignee');
  final projectTextController = TextEditingController(text: 'Project');

// ATTachments

  final attachments = ValueNotifier<List<PlatformFile>>([]);

  void addAttachment({required PlatformFile attachment}) {
    attachments.value.add(attachment);
    attachments.notifyListeners();
  }

  void removeAttachment(int index) {
    attachments.value.removeAt(index);
    attachments.notifyListeners();
  }

  final pickedUser = ValueNotifier<UserProfileModel>(
    UserProfileModel(
      avatarUrl: '',
      createdAt: DateTime.now(),
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
    _assignedTo = pickedUser.value.id;

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

  void changeIsClickedStatus(bool newValue) {
    isClickedAddTask.value = newValue;
    isClickedAddTask.notifyListeners();
  }

  final isShowPickUserWidget = ValueNotifier(false);

  final isShowProjectWidget = ValueNotifier(false);

  final panelStatus = ValueNotifier<InputFieldStatus>(InputFieldStatus.hide);

  void changePanelStatus({required InputFieldStatus newStatus}) {
    panelStatus.value = newStatus;
    panelStatus.notifyListeners();
  }

// validation

  bool isEdit = false;
  bool hasAttachments() => attachments.value.isEmpty ? false : true;

  Future<void> tryValidate({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    try {
      log('tryValidate');
      String taskId = '';
      if (formKey.currentState!.validate()) {
        log('is Valid');
        FocusScope.of(context).unfocus();
        changeIsClickedStatus(false);
        if (_assignedTo == null) {
          if (pickedProject.value.id.isEmpty) {
            final projects = await projectController.fetchAllProjects();
            log('projects ${projects.length}');
            for (var i = 0; i < projects.length; i++) {
              if (projects[i].title == 'Personal') {
                _assignedTo = projects[i].ownerId;
                _projectId = projects[i].id;
                break;
              }
            }
          } else {
            _assignedTo = pickedProject.value.ownerId;
          }
          log('is edit $isEdit');
          if (isEdit) {
            print('update task');
          } else {
            final model = await createTask();
            log('model : $model');
            taskId = model.id;
          }

          hasAttachments() ? uploadTaskAttachment(taskId: taskId) : null;
        } else {
          log('is assigned');
          if (isEdit) {
          } else {
            final model = await createTask();

            taskId = model.id;
          }

          hasAttachments() ? uploadTaskAttachment(taskId: taskId) : null;
        }

        // NavigationService.navigateTo(
        //   context,
        //   Pages.tasks,
        // );

      }
    } catch (e) {
      throw Failure(e.toString());
    } finally {
      changeIsClickedStatus(true);
    }
  }

// Core operations

  Future<TaskModel> createTask() async {
    try {
      List<String> members = [];
      if (taskMembers.value.isNotEmpty) {
        for (var element in taskMembers.value) {
          members.add(element.id);
        }
      }

      return await _taskRepository.createTask(
        title: titleController.text,
        description: descriptionController.text,
        assignedTo: _assignedTo,
        projectId: _projectId ?? '',
        dueDate: (pickedDate.value.day == DateTime.now().day ||
                pickedDate.value.day < DateTime.now().day)
            ? null
            : DateFormat("yyyy-MM-ddThh:27:mm.ssssss").format(pickedDate.value),
        members: members,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteTask({required String projectId}) async {
    try {
      await _taskRepository.deleteTask(projectId: projectId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateTask({
    required String assignedTo,
    required String projectId,
    required String taskId,
    List<String>? members,
  }) async {
    try {
      await _taskRepository.updateTask(
        taskId: taskId,
        title: titleController.text,
        description: descriptionController.text,
        assignedTo: assignedTo,
        projectId: projectId,
        dueDate: pickedDate.value,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> uploadTaskAttachment({required String taskId}) async {
    try {
      for (int i = 0; i < attachments.value.length; i++) {
        await _taskRepository.uploadTaskAttachment(
          name: attachments.value[i].name,
          file: File(attachments.value[i].path ?? ""),
          taskId: taskId,
          isFile: fileController.isValidImageFormat(attachments.value[i].name)
              ? true
              : false,
        );
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

// FAKE
  List<TaskModel> tasks = [];
  Future<void> fetchTasks() async {
    final list1 = await fetchUserTasks();
    final list2 = await fetchAssignedToTasks();
    final list3 = await fetchParticipateInTasks();
    for (var i = 0; i < list1.length; i++) {
      tasks.add(list1[i]);
    }
    for (var i = 0; i < list2.length; i++) {
      tasks.add(list2[i]);
    }
    for (var i = 0; i < list2.length; i++) {
      tasks.add(list3[i]);
    }
    log('task model ${tasks.length}');
  }

  Future<List<TaskModel>> fetchUserTasks() async {
    try {
      return await _taskRepository.fetchUserTasks();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<TaskModel>> fetchAssignedToTasks() async {
    try {
      return await _taskRepository.fetchAssignedToTasks();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<TaskModel>> fetchParticipateInTasks() async {
    try {
      return await _taskRepository.fetchParticipateInTasks();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
