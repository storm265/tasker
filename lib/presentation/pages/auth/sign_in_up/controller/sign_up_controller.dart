import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required AuthRepositoryImpl authRepository,
    required this.formValidatorController,
    required this.imgPickerController,
    required SecureStorageSource storageSource,
  })  : _authRepository = authRepository,
        _storageSource = storageSource;

  final AuthRepositoryImpl _authRepository;

  final FormValidatorController formValidatorController;

  final ImageController imgPickerController;

  final SecureStorageSource _storageSource;
  
  final formKey = GlobalKey<FormState>();

  final isActiveSubmitButton = ValueNotifier<bool>(true);

  final isActiveScrolling = ValueNotifier<bool>(false);


  void changeSubmitButtonValue({required bool isActive}) {
    isActiveSubmitButton.value = isActive;
    isActiveSubmitButton.notifyListeners();
  }

  Future<void> trySignUp({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      changeSubmitButtonValue(isActive: false);

      if (imgPickerController.shouldUploadAvatar()) {
        if (imgPickerController.isValidAvatar(context: context)) {
          if (formKey.currentState!.validate()) {
            await _signUp(
              context: context,
              username: userName,
              email: email,
              password: password,
            );
            final imageResponse = await imgPickerController.uploadAvatar();
            log('avatar respose $imageResponse');
            await _storageSource.storageApi
                .saveUserData(
                    type: StorageDataType.avatarUrl, value: imageResponse)
                .then((_) {
              MessageService.displaySnackbar(
                  message: 'Sign up success!', context: context);

              NavigationService.navigateTo(
                  context, Pages.navigationReplacement);
            });
          } else {
            throw Failure('Form is not valid');
          }
        }
      } else {
        if (formKey.currentState!.validate()) {
          await _signUp(
            context: context,
            username: userName,
            email: email,
            password: password,
          ).then((_) {
            MessageService.displaySnackbar(
                message: 'Sign up success!', context: context);

            NavigationService.navigateTo(context, Pages.navigationReplacement);
          });
        } else {
          throw Failure('Form is not valid');
        }
      }
    } catch (e) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
      throw Failure(e.toString());
    } finally {
      changeSubmitButtonValue(isActive: true);
    }
  }

  Future<void> _signUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      final authModel = await _authRepository.signUp(
        nickname: username,
        email: email,
        password: password,
      );

      await _storageSource.storageApi
          .saveUserData(type: StorageDataType.id, value: authModel.id);
      await _storageSource.storageApi
          .saveUserData(type: StorageDataType.email, value: email);
      await _storageSource.storageApi
          .saveUserData(type: StorageDataType.password, value: password);
      await _storageSource.storageApi
          .saveUserData(type: StorageDataType.username, value: username);
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.refreshToken,
        value: authModel.refreshToken,
      );
      await _storageSource.storageApi.saveUserData(
        type: StorageDataType.accessToken,
        value: authModel.accessToken,
      );
      MessageService.displaySnackbar(
        context: context,
        message:
            'Token will expire: ${DateTime.fromMillisecondsSinceEpoch(authModel.expiresIn)
              ..day
              ..month}',
      );
    } catch (e, t) {
      debugPrint(' error: $e, trace: $t');
      throw Failure('Sign up failed');
    }
  }

}
