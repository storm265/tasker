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
  final _supabase = SupabaseSource().restApiClient;
  final pickedFile = ValueNotifier(XFile(_defaultAssetPath));
  final ImagePicker picker = ImagePicker();

  final _authRepository = AuthRepositoryImpl();
  final _userProfileRepository = UserProfileRepositoryImpl();
  final _userRepository = UserRepositoryImpl();

  final formValidatorController = FormValidatorController();
  final formKey = GlobalKey<FormState>();
  final double leftPadding = 25;
  final isClickedSubmitButton = ValueNotifier(true);

  Future<void> signUpValidate({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    if (formKey.currentState!.validate() &&
        !pickedFile.value.path.contains('assets')) {
      isClickedSubmitButton.value = false;
      isClickedSubmitButton.notifyListeners();
      await signUp(
        context: context,
        username: userName,
        email: email,
        password: password,
      ).then((_) => NavigationService.navigateTo(context, Pages.home));
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
      await _authRepository.signUp(
        context: context,
        email: email,
        password: password,
      );
      await _userRepository.insertUser(email: email, password: password);
      await _userProfileRepository.insertProfile(
        avatarUrl: pickedFile.value.name,
        username: username,
      );
      await uploadAvatar();
    } catch (e) {
      MessageService.displaySnackbar(
          context: context, message: 'signUp error: $e');
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

  Future<void> uploadAvatar() async {
    try {
      if (pickedFile.value.path.contains('assets')) {
        ErrorService.printError('Pick image!');
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
