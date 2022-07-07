import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

enum InputFieldStatus {
  showUserPanel,
  showProjectPanel,
  hide,
}

class AddTaskController extends ChangeNotifier {
  ProjectRepositoryImpl controllerProject;
  UserProfileRepositoryImpl controllerUserProfile;
  UserProfileRepositoryImpl userProfileRepository;
  final formKey = GlobalKey<FormState>();

  AddTaskController({
    required this.controllerProject,
    required this.controllerUserProfile,
    required this.userProfileRepository,
  });

  final selectedUsers = ValueNotifier<List<UserProfileModel>>([]);

  void addMember({required UserProfileModel chipTitle}) {
    selectedUsers.value.add(chipTitle);
    selectedUsers.notifyListeners();
  }

  void removeMember({required int index}) {
    selectedUsers.value.removeAt(index);
    selectedUsers.notifyListeners();
  }

  void clearMemberList() {
    selectedUsers.value.clear();
    selectedUsers.notifyListeners();
  }

  final forTextController = TextEditingController(text: 'Assignee');
  final inTextController = TextEditingController(text: 'Project');

  final files = ValueNotifier<List<PlatformFile>>([]);
  final pickedTime = ValueNotifier<DateTime?>(null);

  final pickedUser = ValueNotifier<UserProfileModel>(
    UserProfileModel(avatarUrl: '', createdAt: '', username: '', uuid: ''),
  );

  void pickUser({required UserProfileModel newUser}) {
    pickedUser.value = newUser;
    forTextController.text = pickedUser.value.toString();
    pickedUser.notifyListeners();
  }

  final pickerProject = ValueNotifier<ProjectModel>(
    ProjectModel(color: '', createdAt: '', title: '', uuid: ''),
  );

  void pickProject({required ProjectModel newProject}) {
    pickerProject.value = newProject;
    inTextController.text = pickerProject.value.toString();
    pickerProject.notifyListeners();
  }

  XFile? pickedFile = XFile('');
  final picker = ImagePicker();

  final isShowPickUserWidget = ValueNotifier(false);
  final isShowProjectWidget = ValueNotifier(false);
  final panelStatus = ValueNotifier<InputFieldStatus>(InputFieldStatus.hide);

  late String userName = '', image = '';

  void changePanelStatus({required InputFieldStatus newStatus}) {
    panelStatus.value = newStatus;
    panelStatus.notifyListeners();
  }

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
            context: context, message: 'You cant put huge file');
      } else {
        PlatformFile file = result.files.first;
        files.value.add(file);
      }
      files.notifyListeners();
    } catch (e) {
      ErrorService.printError('pickAvatar error: $e');
      rethrow;
    }
  }

  Future<List<String>> fetchCommentInfo() async {
    try {
      image = await userProfileRepository.fetchAvatar();
      userName = await userProfileRepository.fetchUserName();
      return [image, userName];
    } catch (e) {
      ErrorService.printError("Error in ProfileController  getUserData() :$e ");
      rethrow;
    }
  }

  void disposeAll() {
    selectedUsers.dispose();
    pickedUser.dispose();
    pickerProject.dispose();
    forTextController.dispose();
    inTextController.dispose();
    isShowPickUserWidget.dispose();
    isShowProjectWidget.dispose();
    panelStatus.dispose();
    pickedTime.dispose();
    files.dispose();
  }
}
