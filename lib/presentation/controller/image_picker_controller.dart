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

  final _emptyImage = const PlatformFile(name: '', size: 0, path: '');
  var pickedFile =
      ValueNotifier(const PlatformFile(name: '', size: 0, path: ''));

  bool get wrongFormat =>
      pickedFile.value.extension != 'jpeg' &&
      pickedFile.value.extension != 'png';

  final _maxImageSize = 8000 * 1000;
  final _maxFileSize = 26214 * 1000;

  Future<PlatformFile> pickAvatar({
    required BuildContext context,
    bool isImagePicker = true,
  }) async {
    final int maxSize = isImagePicker ? _maxImageSize : _maxFileSize;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowCompression: true,
            type: FileType.custom,
            allowedExtensions: [
              'jpeg',
              'png',
            ],
          ) ??
          const FilePickerResult([]);
      pickedFile.value = result.files.last;
      pickedFile.notifyListeners();
      log('picker image path : ${pickedFile.value.path}');
      log('picker extension : ${pickedFile.value.extension}');
      log('wrongFormat: $wrongFormat');
      log('contains jpeg : ${pickedFile.value.extension == 'jpeg'}');
      log('contains png : ${pickedFile.value.extension == 'png'}');
      if (result.files.last.size >= maxSize) {
        pickedFile.value = _emptyImage;
        result.files.clear();
        pickedFile.notifyListeners();
        throw MessageService.displaySnackbar(
          message: 'You cant put huge file',
          context: context,
        );
      } else if (pickedFile.value.extension != 'jpeg' &&
          pickedFile.value.extension != 'png') {
        pickedFile.value = _emptyImage;
        result.files.clear();
        pickedFile.notifyListeners();
        throw MessageService.displaySnackbar(
          message: 'Wrong image, supported formats: .jpeg, .png.',
          context: context,
        );
      } else {
        log('corrected image');
        pickedFile.value = result.files.last;
        pickedFile.notifyListeners();
        return pickedFile.value = result.files.last;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  bool shouldUploadAvatar() => pickedFile.value.path != '';

  bool isValidAvatar({required BuildContext context}) {
    try {
      if (wrongFormat) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateAvatar({required BuildContext context}) async {
    try {
      await pickAvatar(context: context);
      if (isValidAvatar(context: context)) {
        imageCache.clear();
        log('image is valid!');
        await uploadAvatar();
      }
    } catch (e) {
      log('update img error : $e');
      throw Failure(e.toString());
    }
  }

  Future<String> uploadAvatar() async {
    try {
      final image = await _avatarStorageRepository.uploadAvatar(
        name: pickedFile.value.name,
        file: File(pickedFile.value.path!),
      );
      return image;
    } catch (e) {
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
