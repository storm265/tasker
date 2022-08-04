import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class UpdateTokenService {
  final AuthRepositoryImpl _authRepository;
  final SecureStorageService _secureStorageService;

  UpdateTokenService({
    required AuthRepositoryImpl authRepository,
    required SecureStorageService secureStorageService,
  })  : _authRepository = authRepository,
        _secureStorageService = secureStorageService;

  Future<void> updateToken({required BuildContext context}) async {
    try {
      final email = await _secureStorageService.getUserData(
              type: StorageDataType.email) ??
          '';
      final password = await _secureStorageService.getUserData(
              type: StorageDataType.password) ??
          '';

      final response = await _authRepository.signIn(
        email: email,
        password: password,
      );

      final expiresAt =
          DateTime.fromMillisecondsSinceEpoch(response.model.expiresIn * 1000);

      log('Time now: ${DateTime.now()}');
      log('expiresAt: $expiresAt');
      if (DateTime.now().isAfter(expiresAt)) {
        log('*** Token is expired *** ');
        log('*** Updating token *** ');
        // final response = await _authRepository.refreshToken();
        // await _secureStorageService.saveUserData(
        //     type: StorageDataType.refreshToken,
        //     value: response[AuthScheme.refreshToken]);
        log('*** Token updated *** ');
      }
    } catch (e) {
      ErrorService.printError('Update token error $e');
    }
  }
}
