import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required this.authRepository,
    required this.userProfileRepository,
    required this.userRepository,
    required this.formValidatorController,
    required this.imagePickerController,
  });

  final AuthRepositoryImpl authRepository;
  final UserProfileRepositoryImpl userProfileRepository;
  final UserRepositoryImpl userRepository;
  final FormValidatorController formValidatorController;
  final ImageController imagePickerController;
  final formKey = GlobalKey<FormState>();
  final isClickedSubmitButton = ValueNotifier(true);

  Future<void> signUpValidate({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
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
  }

  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await authRepository.signUp(
        context: context,
        email: email,
        password: password,
      );
      if (response.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: response.error!.message.toString(),
        );
      } else {
        await userRepository.insertUser(email: email, password: password);
        await userProfileRepository.insertProfile(
          avatarUrl: imagePickerController.pickedFile.value.name,
          username: username,
        );
        await imagePickerController
            .uploadAvatar(context: context)
            .then((_) => NavigationService.navigateTo(context, Pages.home));
      }
    } catch (e) {
      MessageService.displaySnackbar(context: context, message: '$e');
    }
  }

  void disposeValues() {
    imagePickerController.dispose();
    isClickedSubmitButton.dispose();
  }
}
