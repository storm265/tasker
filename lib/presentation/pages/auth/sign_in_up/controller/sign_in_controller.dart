import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class SignInController extends ChangeNotifier {
  final _authRepository = AuthRepositoryImpl();
  final formValidatorController = FormValidatorController();
  final formKey = GlobalKey<FormState>();
  final double left = 25;

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

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _authRepository.signIn(
        context: context,
        email: email,
        password: password,
        navigatorCallback: () =>
            NavigationService.navigateTo(context, Pages.home),
      );
    } catch (e) {
      throw Exception('Error in signIn() controller: $e');
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    await _authRepository.resetPassword(context: context, email: email);
    NavigationService.navigateTo(context, Pages.newPassword);
  }
}
