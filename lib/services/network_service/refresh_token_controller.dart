import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class RefreshTokenController {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final ProfileController _profileController;
  final AuthRepositoryImpl _authRepository;
  final SecureStorageSource _secureStorageSource;

  RefreshTokenController(
      {required AuthRepositoryImpl authRepository,
      required SecureStorageSource secureStorageSource,
      required ProfileController profileController})
      : _authRepository = authRepository,
        _secureStorageSource = secureStorageSource,
        _profileController = profileController;

  Future<void> updateToken({required VoidCallback callback}) async {
    try {
      final accessToken = await _secureStorageSource.getUserData(
          type: StorageDataType.accessToken);
      log('accessToken token $accessToken');

      if (accessToken != null) {
        final model = await _authRepository.refreshToken();
// if got model then save tokens;
        if (model.userId.isNotEmpty) {
          await _secureStorageSource.saveData(
            type: StorageDataType.accessToken,
            value: model.accessToken,
          );
          await _secureStorageSource.saveData(
            type: StorageDataType.refreshToken,
            value: model.refreshToken,
          );
          log('updated');
        } else {
          // if still got 401
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(
            Pages.signIn.type,
            (route) => false,
          );
          // _profileController.signOut(context: context);
        }

        log('resolve');
        callback();
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
