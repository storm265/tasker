import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

const _jpeg = 'jpeg';
const _png = 'png';
const _jpg = 'jpg';

class FileController extends ChangeNotifier {
  final UserProfileRepositoryImpl _userRepository = UserProfileRepositoryImpl(
    userProfileDataSource: UserProfileDataSourceImpl(
      secureStorageService: SecureStorageSource(),
      network: NetworkSource(),
    ),
  );

  final _emptyImage = const PlatformFile(name: '', size: 0, path: '');

  var pickedFile =
      ValueNotifier(const PlatformFile(name: '', size: 0, path: ''));

  bool isValidImageFormat(String image) {
    if (image.endsWith(_jpeg) || image.endsWith(_png) || image.endsWith(_jpg)) {
      return true;
    } else {
      return false;
    }
  }

  final _maxImageSize = 5000 * 1024; // 5mb
  final _maxFileSize = 26000 * 1024; // 26mb

  Future<PlatformFile> pickAvatar({
    required BuildContext context,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowCompression: true,
            type: FileType.custom,
            allowedExtensions: [
              _jpeg,
              _png,
              _jpg,
            ],
          ) ??
          const FilePickerResult([]);
      pickedFile.value = result.files.last;
      pickedFile.notifyListeners();

      debugPrint('picker image path : ${pickedFile.value.path}');
      debugPrint('picker extension : ${pickedFile.value.extension}');
      debugPrint(
          'wrongFormat: ${isValidImageFormat(pickedFile.value.extension ?? '')}');

      if (result.files.last.size >= _maxImageSize) {
        pickedFile.value = _emptyImage;
        result.files.clear();
        pickedFile.notifyListeners();
        throw MessageService.displaySnackbar(
          message: 'You cant put huge file',
          context: context,
        );
      } else if (isValidImageFormat(pickedFile.value.extension ?? '')) {
        pickedFile.value = result.files.last;
        pickedFile.notifyListeners();
        return pickedFile.value = result.files.last;
      } else {
        pickedFile.value = _emptyImage;
        result.files.clear();
        pickedFile.notifyListeners();
        throw MessageService.displaySnackbar(
          message: 'Wrong image, supported formats: .$_jpeg, .$_jpg, .$_png.',
          context: context,
        );
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<PlatformFile> pickFile({required BuildContext context}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result!.files.first.size >= _maxFileSize) {
        result.files.clear();
        throw MessageService.displaySnackbar(
          message: 'You cant put huge file',
          context: context,
        );
      } else {
        PlatformFile file = result.files.first;
        return file;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  bool shouldUploadAvatar() => pickedFile.value.path != '';

  Future<void> updateAvatar({
    required BuildContext context,
    required ProfileController profileController,
  }) async {
    try {
      await pickAvatar(context: context);
      if (isValidImageFormat(pickedFile.value.extension ?? '') &&
          pickedFile.value.name.isNotEmpty) {
        log('image is valid!');

        await uploadAvatar().then((_) => Navigator.pop(context));
        await profileController.clearImage();
      }
    } catch (e, t) {
      log('update img error : $e, $t');
      throw Failure(e.toString());
    }
  }

  Future<String> uploadAvatar() async {
    try {
      final image = await _userRepository.uploadAvatar(
        name: pickedFile.value.name,
        file: File(pickedFile.value.path ?? ''),
      );
      return image;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
