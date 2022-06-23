import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/supabase/constants.dart';

const _defaultAssetPath = 'assets/grey_avatar.jpg';

class SignUpController extends ChangeNotifier {
  final pickedFile = ValueNotifier(XFile(_defaultAssetPath));
  final ImagePicker picker = ImagePicker();

  final _authRepository = AuthRepositoryImpl();
  final _userProfileRepository = UserProfileRepositoryImpl();
  final _userRepository = UserRepositoryImpl();

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _authRepository
          .signIn(
            context: context,
            email: email,
            password: password,
          )
          .then((_) => NavigationService.navigateTo(context, Pages.home));
    } catch (e) {
      throw Exception('Error in signIn() controller: $e');
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

      await uploadAvatar()
          .then((_) => NavigationService.navigateTo(context, Pages.home));
    } catch (e) {
      MessageService.displaySnackbar(
          context: context, message: 'signUp error: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _authRepository.signOut(context: context);
    } catch (e) {
      ErrorService.printError('Error in signOut() controller: $e');
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    await _authRepository
        .resetPassword(
          context: context,
          email: email,
        )
        .then(
          (_) => NavigationService.navigateTo(
            context,
            Pages.newPassword,
          ),
        );
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
        await SupabaseSource().restApiClient.storage.from('avatar').upload(
              pickedFile.value.name,
              File(pickedFile.value.path),
            );
      }
    } catch (e) {
      ErrorService.printError('uploadAvatar error: $e');
    }
  }
}
