import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/connection_checker.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class SignUpController extends ChangeNotifier with ConnectionCheckerMixin {
  final AuthRepositoryImpl _authRepository;
  final FormValidatorController formValidatorController;
  final FileProvider fileController;
  final SecureStorageSource _storageSource;

  SignUpController({
    required AuthRepositoryImpl authRepository,
    required this.formValidatorController,
    required this.fileController,
    required SecureStorageSource storageSource,
  })  : _authRepository = authRepository,
        _storageSource = storageSource;

  final formKey = GlobalKey<FormState>();

  final isActiveSignUpButton = ValueNotifier<bool>(true);

  void changeSignUpButtonValue({required bool isActive}) {
    isActiveSignUpButton.value = isActive;
    isActiveSignUpButton.notifyListeners();
  }

  Future<void> trySignUp({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    changeSignUpButtonValue(isActive: false);
    if (await isConnected()) {
      try {

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
        if (fileController.shouldUploadAvatar()) {
          if (fileController
              .isValidImageFormat(fileController.pickedFile.value.extension!)) {
            final imageResponse = await fileController.uploadAvatar();
            await _storageSource.storageApi.saveData(
              type: StorageDataType.avatarUrl,
              value: imageResponse,
            );
          }
        }

        await Future.delayed(
          Duration.zero,
          () => NavigationService.navigateTo(
            context,
            Pages.navigationReplacement,
          ),
        );
      } catch (e) {
        if (!e.toString().contains('Scaffold')) {
          throw MessageService.displaySnackbar(
            message: e.toString(),
            context: context,
          );
        }
      } finally {
        changeSignUpButtonValue(isActive: true);
      }
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
      changeSignUpButtonValue(isActive: true);
    }
  }

  Future<void> _signUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
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
  }
}
