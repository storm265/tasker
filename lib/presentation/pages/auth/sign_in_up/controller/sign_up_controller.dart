import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/supabase/constants.dart';

const _defaultAssetPath = 'assets/grey_avatar.jpg';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required this.authRepository,
    required this.userProfileRepository,
    required this.userRepository,
    required this.formValidatorController,
  });

  final AuthRepositoryImpl authRepository;
  final UserProfileRepositoryImpl userProfileRepository;
  final UserRepositoryImpl userRepository;
  final FormValidatorController formValidatorController;

  final formKey = GlobalKey<FormState>();
  final isClickedSubmitButton = ValueNotifier(true);
  final _supabase = SupabaseSource().restApiClient;
  final pickedFile = ValueNotifier(XFile(_defaultAssetPath));
  final picker = ImagePicker();

  Future<void> signUpValidate({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
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
          avatarUrl: pickedFile.value.name,
          username: username,
        );
        await uploadAvatar(context: context)
            .then((_) => NavigationService.navigateTo(context, Pages.home));
      }
    } catch (e) {
      MessageService.displaySnackbar(context: context, message: '$e');
    }
  }

  Future<void> pickAvatar() async {
    try {
      pickedFile.value = (await picker.pickImage(source: ImageSource.gallery) ??
          XFile(_defaultAssetPath));
      notifyListeners();
      if (pickedFile.value.name.isEmpty) {
        return;
      }
    } catch (e) {
      ErrorService.printError('pickAvatar error: $e');
    }
  }

  Future<void> uploadAvatar({required BuildContext context}) async {
    try {
      if (pickedFile.value.path.contains('assets')) {
        MessageService.displaySnackbar(
          context: context,
          message: 'Pick avatar.',
        );
      } else {
        await _supabase.storage.from('avatar').upload(
              pickedFile.value.name,
              File(pickedFile.value.path),
            );
      }
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
    }
  }
}
