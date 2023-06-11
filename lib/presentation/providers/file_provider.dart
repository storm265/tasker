// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/data/data_source/user/user_data_source_impl.dart';
import 'package:todo2/data/repository/user_repository_impl.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/network_service/connection_checker.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/secure_storage_service.dart';

class FileProvider extends ChangeNotifier with ConnectionCheckerMixin {
  final UserProfileRepositoryImpl _userRepository = UserProfileRepositoryImpl(
    userProfileDataSource: UserProfileDataSourceImpl(
      secureStorageService: SecureStorageSource(),
      network: NetworkSource(),
    ),
  );

  final _jpeg = 'jpeg';
  final _png = 'png';
  final _jpg = 'jpg';

  final _emptyImage = PlatformFile(
    name: '',
    size: 0,
    path: '',
  );

  final pickedFile = ValueNotifier(
    PlatformFile(
      name: '',
      size: 0,
      path: '',
    ),
  );

  bool isValidImageFormat(String image) =>
      image.endsWith(_jpeg) || image.endsWith(_png) || image.endsWith(_jpg)
          ? true
          : false;

  final _maxImageSize = 5000 * 1024; // 5mb
  final _maxFileSize = 26000 * 1024; // 26mb

  Future<PlatformFile> pickAvatar({
    required BuildContext context,
  }) async {
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

    if (result.files.last.size >= _maxImageSize) {
      pickedFile.value = _emptyImage;
      result.files.clear();
      pickedFile.notifyListeners();

      throw MessageService.displaySnackbar(
        message: LocaleKeys.file_size_is_too_huge.tr(),
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
        message:
            '${LocaleKeys.wrong_image_supported_formats.tr()} .$_jpeg, .$_jpg, .$_png.',
        context: context,
      );
    }
  }

  Future<PlatformFile> pickFile({required BuildContext context}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.first.size >= _maxFileSize) {
      result.files.clear();
      throw MessageService.displaySnackbar(
        message: LocaleKeys.file_size_is_too_huge.tr(),
        context: context,
      );
    } else {
      PlatformFile file = result!.files.first;
      return file;
    }
  }

  bool shouldUploadAvatar() => pickedFile.value.path != '';

  Future<void> updateAvatar({
    required BuildContext context,
    required ProfileController profileController,
    required VoidCallback callback,
  }) async {
    if (await isConnected()) {
      try {
        await pickAvatar(context: context);
        if (isValidImageFormat(pickedFile.value.extension ?? '') &&
            pickedFile.value.name.isNotEmpty) {
          await uploadAvatar().then((_) {
            MessageService.displaySnackbar(
              context: context,
              message: LocaleKeys.avatar_updated.tr(),
            );
            Navigator.pop(context);
          });
          await profileController.clearImage();
          callback();
        }
      } catch (e) {
        MessageService.displaySnackbar(
          context: context,
          message: LocaleKeys.avatar_not_updated.tr(),
        );
      }
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
    }
  }

  Future<String> uploadAvatar() async => await _userRepository.uploadAvatar(
        name: pickedFile.value.name,
        file: File(pickedFile.value.path ?? ''),
      );
}
