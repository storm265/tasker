import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/database_scheme/user_data_scheme..dart';
import 'package:todo2/database/model/auth_model.dart';
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
  final isClickedSubmitButton = ValueNotifier(true);

  Future<void> signInValidate({
    required BuildContext context,
    required String emailController,
    required String passwordController,
  }) async {
    if (formKey.currentState!.validate()) {
      isClickedSubmitButton.value = false;
      isClickedSubmitButton.notifyListeners();

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
      final response = await _authRepository.signIn(
        email: email,
        password: password,
      );

      final userData = await _userProfileRepository.fetchCurrentUser(
        accessToken: response.model.accessToken,
        id: response.model.userId,
      );

      Future.wait([
        _storageSource.storageApi.saveUserData(
          type: StorageDataType.id,
          value: response.model.userId,
        ),
        _storageSource.storageApi.saveUserData(
          type: StorageDataType.email,
          value: email,
        ),
        _storageSource.storageApi.saveUserData(
          type: StorageDataType.username,
          value: userData[AuthScheme.username],
        ),
        _storageSource.storageApi.saveUserData(
          type: StorageDataType.avatarUrl,
          value: userData[AuthScheme.avatarUrl],
        ),
        _storageSource.storageApi.saveUserData(
          type: StorageDataType.refreshToken,
          value: response.model.refreshToken,
        ),
        _storageSource.storageApi.saveUserData(
          type: StorageDataType.accessToken,
          value: response.model.accessToken,
        ),
      ]).then((value) => NavigationService.navigateTo(context, Pages.home));
      isClickedSubmitButton.value = true;
      isClickedSubmitButton.notifyListeners();
    } catch (e) {
      ErrorService.printError('Error in signIn() controller: $e');
      rethrow;
    }
  }

  void disposeObjects() {
    isClickedSubmitButton.dispose();
  }
}
