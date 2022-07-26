import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignInController extends ChangeNotifier {
  final AuthRepositoryImpl authRepository;
  final FormValidatorController formValidatorController;
  final SecureStorageSource storageSource;

  SignInController({
    required this.storageSource,
    required this.authRepository,
    required this.formValidatorController,
  });

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

      isClickedSubmitButton.value = true;
      isClickedSubmitButton.notifyListeners();
    }
  }

  Future<Map<String, dynamic>> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRepository.signIn(
        email: email,
        password: password,
      );
      if (response.statusCode != 200) {
        MessageService.displaySnackbar(
          context: context,
          message: response.statusMessage!,
        );
      } else {
        await Future.delayed(
          const Duration(seconds: 0),
          () => NavigationService.navigateTo(context, Pages.home),
        );
      }
      return response.data[AuthScheme.data];
    } catch (e) {
      ErrorService.printError('Error in signIn() controller: $e');
      rethrow;
    }
  }

  void disposeObjects() {
    isClickedSubmitButton.dispose();
  }
}
