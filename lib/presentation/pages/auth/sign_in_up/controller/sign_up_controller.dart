import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/interfaces/scrollable.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/interfaces/submitable.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class SignUpController extends ChangeNotifier
    implements IsScrollable, Submitable {
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
  final scrollController = ScrollController();

  @override
  void changeSubmitButtonValue({required bool isActive}) {
    isActiveSubmitButton.value = isActive;
    isActiveSubmitButton.notifyListeners();
  }

  @override
  void changeScrollStatus({required bool isActive}) {
    isActiveScrolling.value = isActive;
    isActiveScrolling.notifyListeners();
    if (!isActiveScrolling.value) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent - 0.2,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  void setTrue() {
    isActiveScrolling.value = true;
    isActiveScrolling.notifyListeners();
  }

  Future<void> signUpValidate({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      changeSubmitButtonValue(isActive: false);
      if (imgPickerController.shouldUploadAvatar()) {
        if (imgPickerController.isValidAvatar(context: context)) {
          log('is valid avatar');
          if (formKey.currentState!.validate()) {
            log('form is valid');

            log('sign up with avatar avatr');
            // await signUp(
            //   context: context,
            //   username: userName,
            //   email: email,
            //   password: password,
            // );
            // final imageResponse = await imgPickerController.uploadAvatar();
            // await _storageSource.storageApi.saveUserData(
            //     type: StorageDataType.avatarUrl, value: imageResponse);
            throw Failure('sign up ok');
          }
        } else {
          throw Failure('Form is not valid');
        }
      } else {
        log('withoud avatr');
        if (formKey.currentState!.validate()) {
          log('form is valid');
          log('form is sign up');

          // await signUp(
          //   context: context,
          //   username: userName,
          //   email: email,
          //   password: password,
          // );
          throw Failure('sign up ok');
        } else {
          throw Failure('Form is not valid');
        }
      }
    } catch (e) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
      throw Failure('Form is not valid');
    } finally {
      changeSubmitButtonValue(isActive: true);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      final signUpResponse = await _authRepository.signUp(
        nickname: username,
        email: email,
        password: password,
      );

      if (signUpResponse.id != 'null') {
        await Future.wait([
          _storageSource.storageApi
              .saveUserData(type: StorageDataType.id, value: signUpResponse.id),
          _storageSource.storageApi
              .saveUserData(type: StorageDataType.email, value: email),
          _storageSource.storageApi
              .saveUserData(type: StorageDataType.password, value: password),
          _storageSource.storageApi
              .saveUserData(type: StorageDataType.username, value: username),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.refreshToken,
            value: signUpResponse.refreshToken,
          ),
          _storageSource.storageApi.saveUserData(
            type: StorageDataType.accessToken,
            value: signUpResponse.accessToken,
          ),
        ]);
      }
      MessageService.displaySnackbar(
        context: context,
        message:
            'Token will expire: ${DateTime.fromMillisecondsSinceEpoch(signUpResponse.expiresIn)}',
      );
    } catch (e, t) {
      throw Failure('Sign up failed $e : trace $t');
    }
  }

  void disposeObjects() {
    imgPickerController.dispose();
    isActiveSubmitButton.dispose();
    isActiveScrolling.dispose();
    scrollController.dispose();
  }
}
