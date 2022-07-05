import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/new_task.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

class AddTaskController extends ChangeNotifier {
  final files = ValueNotifier<List<PlatformFile>>([]);
  final pickedTime = ValueNotifier<DateTime?>(null);
  final projects = ValueNotifier<List<ProjectModel>>([]);

  XFile? pickedFile = XFile('');
  final picker = ImagePicker();

  final isShowPickUserWidget = ValueNotifier(false);
  final isShowProjectWidget = ValueNotifier(false);
  final panelStatus = ValueNotifier<InputFieldStatus>(InputFieldStatus.hide);
  late String userName = '', image = '';
  final userProfileRepository = UserProfileRepositoryImpl();

  void changePanelStatus({required InputFieldStatus newStatus}) {
    panelStatus.value = newStatus;
    panelStatus.notifyListeners();
  }

  void pickTime(DateTime newTime) {
    pickedTime.value = newTime;
    pickedTime.notifyListeners();
  }

  final usersList = ValueNotifier<List<UserProfileModel>>([]);
  void addChip(UserProfileModel chipTitle) {
    usersList.value.add(chipTitle);
    usersList.notifyListeners();
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
}
