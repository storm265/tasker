import 'dart:developer';
import 'package:flutter/semantics.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class RefreshTokenController {
  final AuthRepositoryImpl _authRepository;
  final SecureStorageSource _secureStorageSource;
  RefreshTokenController({
    required AuthRepositoryImpl authRepository,
    required SecureStorageSource secureStorageSource,
  })  : _authRepository = authRepository,
        _secureStorageSource = secureStorageSource;

  Future<void> updateToken({required VoidCallback callback}) async {
    try {
      final accessToken = await _secureStorageSource.getUserData(
          type: StorageDataType.accessToken);
      log('aceess toke $accessToken');
      if (accessToken != null) {
        log('not updated');
        final model = await _authRepository.refreshToken();
        log('updated');
        await _secureStorageSource.saveData(
          type: StorageDataType.accessToken,
          value: model.accessToken,
        );
        await _secureStorageSource.saveData(
          type: StorageDataType.refreshToken,
          value: model.refreshToken,
        );
        log('resolve');
        callback();
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
