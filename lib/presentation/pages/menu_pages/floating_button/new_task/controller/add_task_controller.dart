import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';

final newTaskConroller = NewTaskController();

class NewTaskController extends ChangeNotifier {
  final files = ValueNotifier<List<PlatformFile>>([]);
  final pickedTime = ValueNotifier<DateTime?>(null);

  XFile? pickedFile = XFile('');
  final picker = ImagePicker();

  final isShowPickUserWidget = ValueNotifier(false);
  final isShowProjectWidget = ValueNotifier(false);

  late String userName = '', image = '';
  final userProfileRepository = UserProfileRepositoryImpl();

  void showProjectWidget(bool value) {
    if (isShowProjectWidget.value == false) {
      isShowPickUserWidget.value = value;
      isShowPickUserWidget.notifyListeners();
    }
  }

  void showPickUserWidget(bool value) {
    if (isShowPickUserWidget.value == false) {
      isShowPickUserWidget.value = value;
      isShowPickUserWidget.notifyListeners();
    }
  }

  void pickTime(DateTime pickedTime) {
    this.pickedTime.value = pickedTime;
    notifyListeners();
  }

  final usersList = ValueNotifier<List<UserProfileModel>>([]);
  void addChip(UserProfileModel chipTitle) {
    usersList.value.add(chipTitle);
    notifyListeners();
  }

  Future<void> pickFile() async {
    const int maxSize = 26214400;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result!.files.first.size >= maxSize) {
        result.files.clear();
        log('U cant put huge image');
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

  Future<void> fetchProfileInfo() async {
    try {
      image = await userProfileRepository.fetchAvatar();
      userName = await userProfileRepository.fetchUserName();
    } catch (e) {
      ErrorService.printError("Error in ProfileController  getUserData() :$e ");
      rethrow;
    }
  }
  Future<List<String>> fetchCommentInfo() async {
    try {
      image = await userProfileRepository.fetchAvatar();
      userName = await userProfileRepository.fetchUserName();
      return [image,userName];
    } catch (e) {
      ErrorService.printError("Error in ProfileController  getUserData() :$e ");
      rethrow;
    }
  }
}
