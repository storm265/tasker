import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/supabase/constants.dart';

const _defaultAssetPath = 'assets/grey_avatar.jpg';

class ImageController extends ChangeNotifier {
  final _storagePath = 'avatar';
  final pickedFile = ValueNotifier(XFile(_defaultAssetPath));
  final picker = ImagePicker();
  final _supabase = SupabaseSource().restApiClient;

  bool get _isWrongImageFormat =>
      pickedFile.value.path.endsWith('.jpg') ||
      pickedFile.value.path.endsWith('.gif') ||
      pickedFile.value.path.endsWith('.png');

  Future<void> pickAvatar() async {
    try {
      pickedFile.value = (await picker.pickImage(source: ImageSource.gallery) ??
          XFile(_defaultAssetPath));
      notifyListeners();
      if (pickedFile.value.name.isEmpty) {
        return;
      }
      log(pickedFile.value.path);
    } catch (e) {
      ErrorService.printError('pickAvatar error: $e');
    }
  }

  bool isValidAvatar({required BuildContext context}) {
    if (pickedFile.value.path == _defaultAssetPath) {
      MessageService.displaySnackbar(context: context, message: 'Pick image!');
      return false;
    } else if (!_isWrongImageFormat) {
      MessageService.displaySnackbar(
          context: context, message: 'Wrong image format');
      return false;
    } else {
      return true;
    }
  }

  Future<void> uploadAvatar({required BuildContext context}) async {
    try {
      await _supabase.storage.from(_storagePath).upload(
            pickedFile.value.name,
            File(pickedFile.value.path),
          );
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
    }
  }

  void disposeValues() {
    pickedFile.dispose();
  }
}
