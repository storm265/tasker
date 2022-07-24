import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required this.authRepository,
    required this.userProfileRepository,
    required this.userRepository,
    required this.formValidatorController,
    required this.imagePickerController,
    required this.projectController,
  });

  final AuthRepositoryImpl authRepository;
  final UserProfileRepositoryImpl userProfileRepository;
  final UserRepositoryImpl userRepository;
  final FormValidatorController formValidatorController;
  final ImageController imagePickerController;
  final ProjectController projectController;
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
        nickname: username,
        email: email,
        password: password,
      );
      if (response.statusCode != 200) {
        print(' signUp response.data: ${response.data}');
        MessageService.displaySnackbar(
          context: context,
          message: response.statusMessage!,
        );
      } else {
        // await userRepository.postUser(email: email, password: password);
        // await userProfileRepository.postProfile(
        //   avatarUrl: imagePickerController.pickedFile.value.name,
        //   username: username,
        // );
        // await projectController.postProject(
        //     title: 'Personal', color: colors[0].value.toString());
        await imagePickerController
            .uploadAvatar()
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
