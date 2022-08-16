import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/database/repository/storage/avatar_storage_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

const _defaultAssetPath = 'assets/grey_avatar.jpg';

class ImageController extends ChangeNotifier {
  final AvatarStorageReposiroryImpl _avatarStorageRepository;

  ImageController({required AvatarStorageReposiroryImpl avatarRepository})
      : _avatarStorageRepository = avatarRepository;

  final pickedFile = ValueNotifier(XFile(_defaultAssetPath));
  final picker = ImagePicker();

  bool get _isWrongImageFormat =>
      pickedFile.value.path.endsWith('.jpeg') ||
      pickedFile.value.path.endsWith('.png') ||
      pickedFile.value.path.endsWith('.jpg');

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

      log(pickedFile.value.name);
      if (pickedFile.value.name.isEmpty) {
        return;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  bool isValidAvatar({required BuildContext context}) {
    try {
      if (pickedFile.value.path == _defaultAssetPath) {
        MessageService.displaySnackbar(
          message: 'Pick image!',
          context: context,
        );
        return false;
      } else if (!_isWrongImageFormat) {
        MessageService.displaySnackbar(
          message: 'Wrong image format',
          context: context,
        );
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<String> uploadAvatar({required BuildContext context}) async {
    try {
      bool isValidImage = isValidAvatar(context: context);
      if (isValidImage) {
        final avatarUrl = await _avatarStorageRepository.uploadAvatar(
          name: pickedFile.value.name,
          file: File(pickedFile.value.path),
        );
        log('avatarUrl: $avatarUrl');
        return avatarUrl;
      } else {
        throw MessageService.displaySnackbar(
          message: 'Invalid Image Format',
          context: context,
        );
      }
    } catch (e, t) {
      log('upload avatar error Controller: $e,$t');
      throw Failure(e.toString());
    }
  }

  void disposeValues() {
    try {
      pickedFile.dispose();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
