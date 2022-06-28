import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/database/model/users_profile_model.dart';

import 'package:todo2/services/error_service/error_service.dart';

final newTaskConroller = NewTaskController();

class NewTaskController extends ChangeNotifier {
  final List<String> imageList = [];
  final ValueNotifier<DateTime?> pickedTime = ValueNotifier(null);

  final ValueNotifier<XFile?> pickedFile = ValueNotifier(XFile(''));
  final ImagePicker picker = ImagePicker();

  final isShowPickUserWidget = ValueNotifier(false);
  final isShowProjectWidget = ValueNotifier(false);

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

  final chipTitles = ValueNotifier<List<UserProfileModel>>([]);
  void addChip(UserProfileModel chipTitle) {
    chipTitles.value.add(chipTitle);
    notifyListeners();
  }

  Future<void> pickAvatar() async {
    try {
      pickedFile.value = await picker.pickImage(source: ImageSource.gallery);
      imageList.add(pickedFile.value!.path);
      notifyListeners();
      if (pickedFile.value!.name.isEmpty) {
        return;
      }
    } catch (e) {
      ErrorService.printError('pickAvatar error: $e');
    }
  }
}
