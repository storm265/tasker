import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/repository/storage/avatar_storage_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

const _defaultAssetPath = 'assets/grey_avatar.jpg';

class ImageController extends ChangeNotifier {
  ImageController({required AvatarStorageReposiroryImpl avatarRepository})
      : _avatarStorageRepository = avatarRepository;
  final AvatarStorageReposiroryImpl _avatarStorageRepository;

  final pickedFile = ValueNotifier(XFile(_defaultAssetPath));
  final picker = ImagePicker();

  bool get _isWrongImageFormat =>
      pickedFile.value.path.endsWith('.jpg') ||
      pickedFile.value.path.endsWith('.png');

  Future<void> pickAvatar() async {
    try {
      pickedFile.value = (await picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 50,
            maxHeight: 500,
            maxWidth: 500,
          ) ??
          XFile(_defaultAssetPath));
      pickedFile.notifyListeners();
      if (pickedFile.value.name.isEmpty) {
        return;
      }
    } catch (e) {
      ErrorService.printError('ImageController pickAvatar error: $e');
    }
  }

  bool isValidAvatar({required BuildContext context}) {
    try {
      if (pickedFile.value.path == _defaultAssetPath) {
        MessageService.displaySnackbar(
            context: context, message: 'Pick image!');
        return false;
      } else if (!_isWrongImageFormat) {
        MessageService.displaySnackbar(
            context: context, message: 'Wrong image format');
        return false;
      } else {
        return true;
      }
    } catch (e) {
      ErrorService.printError('ImageController isValidAvatar error: $e');
      rethrow;
    }
  }


  Future<Map<dynamic, dynamic>> uploadAvatar({

    required BuildContext context,
  }) async {
    try {
      bool isValidImage = isValidAvatar(context: context);
      log('isValidImage: $isValidImage');
      if (isValidImage) {
        final response = await _avatarStorageRepository.uploadAvatar(
        
          name: pickedFile.value.name,
          file: File(pickedFile.value.path),
        );
        return response.data[AuthScheme.data];
      } else {
        MessageService.displaySnackbar(
          context: context,
          message: 'Invalid Image Format',
        );
        return {};
      }
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
      rethrow;
    }
  }


  void disposeValues() {
    try {
      pickedFile.dispose();
    } catch (e) {
      ErrorService.printError('ImageController disposeValues error: $e');
    }
  }
}
