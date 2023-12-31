// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/repository/auth_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/providers/user_provider.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/connection_checker.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';

class SignInController extends ChangeNotifier with ConnectionCheckerMixin {
  final AuthRepository _authRepository;
  final FormValidatorController formValidatorController;
  final SecureStorageSource _storageSource;
  final UserProvider _userController;

  SignInController({
    required AuthRepository authRepository,
    required SecureStorageSource storageSource,
    required UserProvider userController,
    required this.formValidatorController,
  })  : _storageSource = storageSource,
        _authRepository = authRepository,
        _userController = userController;

  final formKey = GlobalKey<FormState>();

  final isActiveSignInButton = ValueNotifier(true);

  void changeSignInButtonStatus({required bool isActive}) {
    isActiveSignInButton.value = isActive;
    isActiveSignInButton.notifyListeners();
  }

  Future<void> tryToSignIn({
    required String emailController,
    required String passwordController,
    required BuildContext context,
  }) async {
    changeSignInButtonStatus(isActive: false);
    if (await isConnected()) {
      try {
        if (formKey.currentState!.validate()) {
          await _signIn(
            context: context,
            email: emailController,
            password: passwordController,
          );
        } else {
          throw MessageService.displaySnackbar(
            message: LocaleKeys.form_is_not_valid.tr(),
            context: context,
          );
        }

        await Future.delayed(
          const Duration(milliseconds: 1),
          () => NavigationService.navigateTo(
            context,
            Pages.navigationReplacement,
          ),
        );
      } catch (e) {
        if (!e.toString().contains('Scaffold')) {
          MessageService.displaySnackbar(
            message: e.toString(),
            context: context,
          );
        }
      } finally {
        changeSignInButtonStatus(isActive: true);
      }
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
      changeSignInButtonStatus(isActive: true);
    }
  }

  Future<void> _signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final authModel = await _authRepository.signIn(
      email: email,
      password: password,
    );
    final userData = await _userController.fetchCurrentUser(
      accessToken: authModel.accessToken,
      id: authModel.userId,
    );
    await _storageSource.storageApi.saveData(
      type: StorageDataType.id,
      value: authModel.userId,
    );
    await _storageSource.storageApi.saveData(
      type: StorageDataType.email,
      value: email,
    );
    await _storageSource.storageApi.saveData(
      type: StorageDataType.username,
      value: userData.username,
    );
    await _storageSource.storageApi.saveData(
      type: StorageDataType.avatarUrl,
      value: userData.avatarUrl,
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
