import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class SignInController extends ChangeNotifier {
  final AuthRepositoryImpl authRepository;
  final FormValidatorController formValidatorController;

  SignInController({
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

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRepository.signIn(
       
        email: email,
        password: password,
      );
      // if (response.error != null) {
      //   MessageService.displaySnackbar(
      //     context: context,
      //     message: response.error!.message.toString(),
      //   );
      //   return;
      // }

      // await Future.delayed(
      //   const Duration(seconds: 0),
      //   () => NavigationService.navigateTo(context, Pages.home),
      // );
    } catch (e) {
      ErrorService.printError('Error in signIn() controller: $e');
    }
  }


  void disposeObjects() {
    isClickedSubmitButton.dispose();
  }
}
