import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignInController extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository;
  final FormValidatorController formValidatorController;
  final SecureStorageSource _storageSource;
  final UserController _userController;

  SignInController({
    required AuthRepositoryImpl authRepository,
    required SecureStorageSource storageSource,
    required UserController userController,
    required this.formValidatorController,
  })  : _storageSource = storageSource,
        _authRepository = authRepository,
        _userController = userController;

  final formKey = GlobalKey<FormState>();
  final isActiveSubmitButton = ValueNotifier(true);

  void changeSubmitButtonValue({required bool newValue}) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }

  Future<void> signInValidate({
    required String emailController,
    required String passwordController,
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      await signIn(
        context: context,
        email: emailController,
        password: passwordController,
      );
    }
  }

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      changeSubmitButtonValue(newValue: false);

      final response = await _authRepository.signIn(
        email: email,
        password: password,
      );

      if (response.userId != 'null') {
        // TODO remove repo use controller instead
        final userData = await _userController.fetchCurrentUser(
          accessToken: response.accessToken,
          id: response.userId,
        );

        await Future.wait([
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.id,
            value: response.userId,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.email,
            value: email,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.username,
            value: userData.username,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.avatarUrl,
            value: userData.avatarUrl,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.refreshToken,
            value: response.refreshToken,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.accessToken,
            value: response.accessToken,
          ),
        ]).then((_) => NavigationService.navigateTo(context, Pages.home));
      }
    } catch (e) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
      throw Failure(e.toString());
    } finally {
      changeSubmitButtonValue(newValue: true);
    }
  }

  void disposeObjects() {
    isActiveSubmitButton.dispose();
  }
}
