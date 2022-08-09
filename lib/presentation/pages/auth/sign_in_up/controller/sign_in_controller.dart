import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignInController extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository;
  final FormValidatorController formValidatorController;
  final SecureStorageSource _storageSource;
  final UserProfileRepositoryImpl _userProfileRepository;

  SignInController({
    required AuthRepositoryImpl authRepository,
    required SecureStorageSource storageSource,
    required UserProfileRepositoryImpl userProfileRepository,
    required this.formValidatorController,
  })  : _storageSource = storageSource,
        _authRepository = authRepository,
        _userProfileRepository = userProfileRepository;

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

      if (response.model.userId != 'null') {
        final authModel = response.model;

        final userData = await _userProfileRepository.fetchCurrentUser(
          accessToken: response.model.accessToken,
          id: authModel.userId,
        );

        await Future.wait([
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.id,
            value: authModel.userId,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.email,
            value: email,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.username,
            value: userData.model.username,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.avatarUrl,
            value: userData.model.avatarUrl,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.refreshToken,
            value: authModel.refreshToken,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.accessToken,
            value: authModel.accessToken,
          ),
        ]).then((_) => NavigationService.navigateTo(context, Pages.home));
      }
    } catch (e) {
      ErrorService.printError('Error in signIn() controller: $e');
      rethrow;
    } finally {
      changeSubmitButtonValue(newValue: true);
    }
  }

  void disposeObjects() {
    isActiveSubmitButton.dispose();
  }
}
