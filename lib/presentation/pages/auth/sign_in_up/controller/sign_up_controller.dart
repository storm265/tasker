import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required AuthRepositoryImpl authRepository,
    required this.formValidatorController,
    required this.fileController,
    required SecureStorageSource storageSource,
  })  : _authRepository = authRepository,
        _storageSource = storageSource;

  final AuthRepositoryImpl _authRepository;
  final FormValidatorController formValidatorController;
  final FileController fileController;
  final SecureStorageSource _storageSource;

  final formKey = GlobalKey<FormState>();

  final isActiveSubmitButton = ValueNotifier<bool>(true);

  void changeSubmitButtonValue({required bool isActive}) {
    isActiveSubmitButton.value = isActive;
    isActiveSubmitButton.notifyListeners();
  }

  Future<void> trySignUp({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      changeSubmitButtonValue(isActive: false);

      if (fileController.shouldUploadAvatar()) {
        if (fileController
            .isValidImageFormat(fileController.pickedFile.value.extension!)) {
          if (formKey.currentState!.validate()) {
            await _signUp(
              context: context,
              username: userName,
              email: email,
              password: password,
            );
            final imageResponse = await fileController.uploadAvatar();
            log('avatar respose $imageResponse');
            await _storageSource.storageApi.saveData(
              type: StorageDataType.avatarUrl,
              value: imageResponse,
            );
          } else {
            throw MessageService.displaySnackbar(
              message: LocaleKeys.form_is_not_valid.tr(),
              context: context,
            );
          }
        }
      } else {
        if (formKey.currentState!.validate()) {
          await _signUp(
            context: context,
            username: userName,
            email: email,
            password: password,
          );
        } else {
          throw MessageService.displaySnackbar(
            message: LocaleKeys.form_is_not_valid.tr(),
            context: context,
          );
        }
      }

      MessageService.displaySnackbar(
        message: LocaleKeys.sign_up_success.tr(),
        context: context,
      );

      // ignore: use_build_context_synchronously
      await NavigationService.navigateTo(context, Pages.navigationReplacement);
    } catch (e) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
      throw Failure(e.toString());
    } finally {
      changeSubmitButtonValue(isActive: true);
    }
  }

  Future<void> _signUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      final authModel = await _authRepository.signUp(
        nickname: username,
        email: email,
        password: password,
      );
      await _storageSource.storageApi.saveData(
        type: StorageDataType.id,
        value: authModel.id,
      );
      await _storageSource.storageApi.saveData(
        type: StorageDataType.email,
        value: email,
      );
      await _storageSource.storageApi.saveData(
        type: StorageDataType.password,
        value: password,
      );
      await _storageSource.storageApi.saveData(
        type: StorageDataType.username,
        value: username,
      );
      await _storageSource.storageApi.saveData(
        type: StorageDataType.refreshToken,
        value: authModel.refreshToken,
      );
      await _storageSource.storageApi.saveData(
        type: StorageDataType.accessToken,
        value: authModel.accessToken,
      );
    } catch (e, t) {
      debugPrint(' error: $e, trace: $t');
      throw Failure('Sign up failed');
    }
  }
}
