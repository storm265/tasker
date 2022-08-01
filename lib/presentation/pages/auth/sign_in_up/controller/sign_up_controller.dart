import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignUpController extends ChangeNotifier {
  SignUpController(
    this._authRepository,
    this._userProfileRepository,
    this.formValidatorController,
    this.imagePickerController,
    this._projectController,
    this._storageSource,
  );

  final AuthRepositoryImpl _authRepository;
  final UserProfileRepositoryImpl _userProfileRepository;
  final FormValidatorController formValidatorController;
  final ImageController imagePickerController;
  final ProjectController _projectController;
  final SecureStorageSource _storageSource;
  final formKey = GlobalKey<FormState>();
  final isClickedSubmitButton = ValueNotifier(true);

  Future<void> signUpValidate({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      if (imagePickerController.isValidAvatar(context: context)) {
        if (formKey.currentState!.validate()) {
          isClickedSubmitButton.value = false;
          isClickedSubmitButton.notifyListeners();

          await signUp(
            context: context,
            username: userName,
            email: email,
            password: password,
          );

          isClickedSubmitButton.value = true;
          isClickedSubmitButton.notifyListeners();
        }
      }
    } catch (e) {
      ErrorService.printError('Error in signUpValidate() controller: $e');
    }
  }

  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _authRepository.signUp(
        nickname: username,
        email: email,
        password: password,
      );

      final userSession = response[AuthScheme.userSession];
      log(response.toString());
      await Future.wait([
        _storageSource.storageApi.saveUserData(
            type: StorageDataType.id, value: response[AuthScheme.id]),
        _storageSource.storageApi
            .saveUserData(type: StorageDataType.email, value: email),
        _storageSource.storageApi
            .saveUserData(type: StorageDataType.password, value: password),
        _storageSource.storageApi
            .saveUserData(type: StorageDataType.username, value: username),
        _storageSource.storageApi.saveUserData(
            type: StorageDataType.refreshToken,
            value: userSession[AuthScheme.refreshToken]),
        _storageSource.storageApi.saveUserData(
            type: StorageDataType.accessToken,
            value: userSession[AuthScheme.accessToken]),
      ]);

      final imageResponse = await imagePickerController.uploadAvatar(
        context: context,
      );

      _storageSource.storageApi.saveUserData(
          type: StorageDataType.avatarUrl,
          value: imageResponse[AuthScheme.avatarUrl]);

      await _userProfileRepository
          .postProfile(
        id: response[AuthScheme.id],
        avatarUrl: imageResponse[AuthScheme.avatarUrl],
        username: username,
      )
          .then((_) {
        NavigationService.navigateTo(context, Pages.home);
      });

      print('image reposs: $imageResponse');
    } catch (e, t) {
      ErrorService.printError('$e, $t');
    }
  }

  void disposeValues() {
    imagePickerController.dispose();
    isClickedSubmitButton.dispose();
  }
}
