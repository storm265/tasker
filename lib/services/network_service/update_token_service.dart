import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/refresh_token_controller.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class UpdateTokenService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final RefreshTokenController refreshTokenController = RefreshTokenController(
    authRepository: AuthRepositoryImpl(),
  );

  Future<void> updateToken() async {
    try {
      final String? token = await _secureStorageService.getUserData(
          type: StorageDataType.accessToken);

      if (token != null) {
        log('*** Token is expired *** ');
        final authResponse = await refreshTokenController.updateToken();
        await _secureStorageService.saveUserData(
            type: StorageDataType.refreshToken,
            value: authResponse.refreshToken);
        await _secureStorageService.saveUserData(
            type: StorageDataType.accessToken, value: authResponse.accessToken);

        await Future.delayed(const Duration(seconds: 5));
      }
    } catch (e, t) {
      debugPrint('Update token error: $e,$t');
    }
  }
}
