import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required AuthRepositoryImpl authRepository,
    required this.formValidatorController,
    required this.imagePickerController,
    required SecureStorageSource storageSource,
  })  : _authRepository = authRepository,
        _storageSource = storageSource;

  final AuthRepositoryImpl _authRepository;
  final FormValidatorController formValidatorController;
  final ImageController imagePickerController;
  final SecureStorageSource _storageSource;
  final formKey = GlobalKey<FormState>();
  final isActiveSubmitButton = ValueNotifier(true);

  void changeSubmitButtonValue({required bool newValue}) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }

  Future<void> signUpValidate({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      if (imagePickerController.isValidAvatar(context: context)) {
        if (formKey.currentState!.validate()) {
          await signUp(
            context: context,
            username: userName,
            email: email,
            password: password,
          );
        }
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      changeSubmitButtonValue(newValue: false);
      // final response = await _authRepository.signUp(
      //   nickname: username,
      //   email: email,
      //   password: password,
      // );

      // if (response.id != 'null') {
      //   await Future.wait([
      //     _storageSource.storageApi
      //         .saveUserData(type: StorageDataType.id, value: response.id),
      //     _storageSource.storageApi
      //         .saveUserData(type: StorageDataType.email, value: email),
      //     _storageSource.storageApi
      //         .saveUserData(type: StorageDataType.password, value: password),
      //     _storageSource.storageApi
      //         .saveUserData(type: StorageDataType.username, value: username),
      //     _storageSource.storageApi.saveUserData(
      //       type: StorageDataType.refreshToken,
      //       value: response.refreshToken,
      //     ),
      //     _storageSource.storageApi.saveUserData(
      //       type: StorageDataType.accessToken,
      //       value: response.accessToken,
      //     ),
      //   ]);
      //   final imageResponse =
      //       await imagePickerController.uploadAvatar(context: context);
      //   debugPrint(
      //       'avatarUrl = ${await _storageSource.storageApi.getUserData(type: StorageDataType.avatarUrl)}');
      //   await _storageSource.storageApi
      //       .saveUserData(type: StorageDataType.avatarUrl, value: imageResponse)
      //       .then((_) {
      //     MessageService.displaySnackbar(
      //         message: 'Sign up success!', context: context);
      //     NavigationService.navigateTo(context, Pages.home);
      //   });
      //  }
    } catch (e, t) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
      debugPrint('trace $t');
      throw Failure(e.toString());
    } finally {
      changeSubmitButtonValue(newValue: true);
    }
  }

  void disposeValues() {
    imagePickerController.dispose();
    isActiveSubmitButton.dispose();
  }
}
