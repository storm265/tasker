import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'package:todo2/services/error_service/error_service.dart';

final newTaskConroller = NewTaskController();

class NewTaskController extends ChangeNotifier {
  final List<String> imageList = [];
  final ValueNotifier<DateTime?> pickedTime = ValueNotifier(null);

  final ValueNotifier<XFile?> pickedFile = ValueNotifier(XFile(''));
  final ImagePicker picker = ImagePicker();
  void pickTime(DateTime pickedTime) {
    this.pickedTime.value = pickedTime;
    notifyListeners();
  }

  final chipTitles = ValueNotifier<List<String>>([]);
  void addChip(String chipTitle) {
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