import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

const _jpeg = 'jpeg';
const _png = 'png';
const _jpg = 'jpg';

class ImageController extends ChangeNotifier {
  final UserProfileRepositoryImpl _userRepository;
  final SecureStorageSource _secureStorageSource;

  ImageController({
    required UserProfileRepositoryImpl userRepository,
    required SecureStorageSource secureStorageSource,
  })  : _userRepository = userRepository,
        _secureStorageSource = secureStorageSource;

  final _emptyImage = const PlatformFile(name: '', size: 0, path: '');
  var pickedFile =
      ValueNotifier(const PlatformFile(name: '', size: 0, path: ''));

  bool get wrongFormat =>
      pickedFile.value.extension != _jpeg &&
      pickedFile.value.extension != _png &&
      pickedFile.value.extension != _jpg;

  final _maxImageSize = 4000 * 1000; // 4mb
  final _maxFileSize = 26214 * 1000; // 26mb

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
      debugPrint('wrongFormat: $wrongFormat');

      if (result.files.last.size >= maxSize) {
        pickedFile.value = _emptyImage;
        result.files.clear();
        pickedFile.notifyListeners();
        throw MessageService.displaySnackbar(
          message: 'You cant put huge file',
          context: context,
        );
      } else if (wrongFormat) {
        pickedFile.value = _emptyImage;
        result.files.clear();
        pickedFile.notifyListeners();
        throw MessageService.displaySnackbar(
          message: 'Wrong image, supported formats: .$_jpeg, .$_jpg, .$_png.',
          context: context,
        );
      } else {
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

  Future<void> updateAvatar({
    required BuildContext context,
    required VoidCallback callback,
  }) async {
    try {
      await pickAvatar(context: context);
      if (isValidAvatar(context: context) && pickedFile.value.name.isNotEmpty) {
        final url = await _secureStorageSource.getUserData(
                type: StorageDataType.avatarUrl) ??
            '';
        await CachedNetworkImage.evictFromCache(url);

        log('image is valid!');
        await uploadAvatar().then((_) {
          callback();
          MessageService.displaySnackbar(
            context: context,
            message: 'For apply new avatar restard app',
          );
          Navigator.pop(context);
        });
      }
    } catch (e) {
      log('update img error : $e');
      throw Failure(e.toString());
    }
  }

  Future<String> uploadAvatar() async {
    try {
      final image = await _userRepository.uploadAvatar(
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
