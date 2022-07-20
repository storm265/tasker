import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/data_source/storage/avatar_storage_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/storage/avatar_storage_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

const _defaultAssetPath = 'assets/grey_avatar.jpg';

class ImageController extends ChangeNotifier {
  final avatarStorageRepository = AvatarStorageReposiroryImpl(
      avatarDataSource: AvatarStorageDataSourceImpl());

  final pickedFile = ValueNotifier(XFile(_defaultAssetPath));
  final picker = ImagePicker();

  bool get _isWrongImageFormat =>
      pickedFile.value.path.endsWith('.jpg') ||
      pickedFile.value.path.endsWith('.gif') ||
      pickedFile.value.path.endsWith('.png');

  Future<void> pickAvatar() async {
    try {
      pickedFile.value = (await picker.pickImage(source: ImageSource.gallery) ??
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

  Future<void> pushUpdatedAvatar({
    required BuildContext context,
    required ProfileController profileController,
  }) async {
    try {
      final pushBack = Navigator.pop(context);
      await pickAvatar();
      bool isValidImage = isValidAvatar(context: context);
      if (isValidImage) {
        final response =
            await updateAvatar(profileController: profileController);
        if (response.error == null) {
          MessageService.displaySnackbar(
            context: context,
            message: 'Avatar updated',
          );
          pushBack;
        }
      }
    } catch (e) {
      ErrorService.printError('ImageController pushUpdatedAvatar error: $e');
    }
  }

  Future<void> uploadAvatar() async {
    try {
      await avatarStorageRepository.uploadAvatar(
        name: pickedFile.value.name,
        file: File(pickedFile.value.path),
      );
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
    }
  }

  Future<StorageResponse<String>> updateAvatar(
      {required ProfileController profileController}) async {
    try {
      final response = await avatarStorageRepository.updateAvatar(
        bucketImage: profileController.image,
        file: File(pickedFile.value.path),
      );
      if (response.error != null) {
        log('Error updateAvatar controller: ${response.error}');
      }
      return response;
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
