import 'package:flutter/cupertino.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required this.authRepository,
    required this.userProfileRepository,
    required this.formValidatorController,
    required this.imagePickerController,
    required this.projectController,
    required this.storageSource,
  });

  final AuthRepositoryImpl authRepository;
  final UserProfileRepositoryImpl userProfileRepository;

  final FormValidatorController formValidatorController;
  final ImageController imagePickerController;
  final ProjectController projectController;
  final SecureStorageSource storageSource;
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
      print(response.data);
      print(response.statusCode);
      if (response.statusCode != 200) {
        MessageService.displaySnackbar(
          context: context,
          message: response.data[AuthScheme.message],
        );
      } else {
        final model = Map<String, dynamic>.from(response.data);
        final snapshot = model[AuthScheme.data];

        storageSource.storageApi.putUserData(
          id: snapshot[AuthScheme.id],
          email: email,
          password: password,
          username: username,
          
          refreshToken: snapshot[AuthScheme.refreshToken],
          accessToken: snapshot[AuthScheme.accessToken],
        );

        await userProfileRepository.postProfile(
          id: snapshot[AuthScheme.id],
          avatarUrl: imagePickerController.pickedFile.value.name,
          username: username,
        );
        // TODO push default project
        // await projectController.postProject(
        //     title: 'Personal', color: colors[0].value.toString());

        await imagePickerController
            .uploadAvatar(userId: snapshot[AuthScheme.id])
            .then((_) {
          NavigationService.navigateTo(context, Pages.home);
        });
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
