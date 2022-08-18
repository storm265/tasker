import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
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
    try {
      if (formKey.currentState!.validate()) {
        await signIn(
          context: context,
          email: emailController,
          password: passwordController,
        );
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      changeSubmitButtonValue(newValue: false);

      final authResponse = await _authRepository.signIn(
        email: email,
        password: password,
      );

      if (authResponse.userId != 'null') {
        final userData = await _userController.fetchCurrentUser(
          accessToken: authResponse.accessToken,
          id: authResponse.userId,
        );

        await Future.wait([
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.id,
            value: authResponse.userId,
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
            value: authResponse.refreshToken,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.accessToken,
            value: authResponse.accessToken,
          ),
        ]);
      }
        // TODO testing, remove context
      MessageService.displaySnackbar(
        context: context,
        message: 'Token will expire: ${DateTime.fromMillisecondsSinceEpoch(authResponse.expiresIn)}',
      );
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
