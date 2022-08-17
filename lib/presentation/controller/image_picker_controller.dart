import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/repository/storage/avatar_storage_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

class ImageController extends ChangeNotifier {
  final AvatarStorageReposiroryImpl _avatarStorageRepository;

  ImageController({required AvatarStorageReposiroryImpl avatarRepository})
      : _avatarStorageRepository = avatarRepository;

  var pickedFile =
      ValueNotifier(const PlatformFile(name: '', size: 0, path: ''));

  bool get _isWrongImageFormat =>
      pickedFile.value.extension == 'jpeg' ||
      pickedFile.value.extension == 'png';

  Future<PlatformFile> pickAvatar({
    required BuildContext context,
    bool isImagePicker = true,
  }) async {
    final int maxSize = isImagePicker ? 8000000 : 26214400;
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
            allowCompression: true,
            type: FileType.custom,
            allowedExtensions: [
              'jpeg',
              'png',
            ],
          ) ??
          const FilePickerResult([]);
      pickedFile.notifyListeners();
      if (result.files.last.size >= maxSize) {
        result.files.clear();
        throw MessageService.displaySnackbar(
          message: 'You cant put huge file',
          context: context,
        );
      } else {
        return pickedFile.value = result.files.last;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  bool isValidAvatar({required BuildContext context}) {
    try {
      if (pickedFile.value.path!.isEmpty) {
        MessageService.displaySnackbar(
          message: 'Pick image!',
          context: context,
        );
        return false;
      } else if (!_isWrongImageFormat) {
        MessageService.displaySnackbar(
          message: 'Wrong image, supported formats: .jpeg, .png',
          context: context,
        );
        return false;
      } else {
        MessageService.displaySnackbar(
          message: 'Right',
          context: context,
        );
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
          file: File(pickedFile.value.path!),
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
