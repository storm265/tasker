import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

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

  void changeSubmitButtonStatus({required bool isActive}) {
    isActiveSubmitButton.value = isActive;
    isActiveSubmitButton.notifyListeners();
  }

  Future<void> tryToSignIn({
    required String emailController,
    required String passwordController,
    required BuildContext context,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        changeSubmitButtonStatus(isActive: false);
        await _signIn(
          context: context,
          email: emailController,
          password: passwordController,
        ).then((_) =>
            NavigationService.navigateTo(context, Pages.navigationReplacement));
      } else {
        throw Failure('Form is not valid');
      }
    } catch (e, t) {
      log(' trace : $t');
      throw Failure(e.toString());
    } finally {
      changeSubmitButtonStatus(isActive: true);
    }
  }

  Future<void> _signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      ///
      final authModel = await _authRepository.signIn(
        email: email,
        password: password,
      );

      final userData = await _userController.fetchCurrentUser(
        accessToken: authModel.accessToken,
        id: authModel.userId,
      );

      // TODO: you can just save the whole User object
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.id,
        value: authModel.userId,
      );
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.email,
        value: email,
      );
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.username,
        value: userData.username,
      );
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.avatarUrl,
        value: userData.avatarUrl,
      );
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.refreshToken,
        value: authModel.refreshToken,
      );
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.accessToken,
        value: authModel.accessToken,
      );
    } catch (e, t) {
      log(' trace : $t');
      MessageService.displaySnackbar(
        message: e.toString(),
        context: context,
      );
      throw Failure(e.toString());
    }
  }
}
