import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/refresh_token_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class UpdateTokenService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final RefreshTokenController refreshTokenController = RefreshTokenController(
    authRepository: AuthRepositoryImpl(),
  );

  Future<void> updateToken() async {
    // try {
    //   log('*** Token is expired *** ');
    //   log('refresj token :   ${await _secureStorageService.getUserData(type: StorageDataType.refreshToken)} ');

    //   final authResponse = await refreshTokenController.updateToken();
    //   await _secureStorageService.saveUserData(
    //       type: StorageDataType.refreshToken, value: authResponse.refreshToken);
    //   await _secureStorageService.saveUserData(
    //       type: StorageDataType.accessToken, value: authResponse.accessToken);
    // } catch (e) {
    //   throw Failure(e.toString());
    // }
  }
}
