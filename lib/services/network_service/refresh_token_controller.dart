import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class RefreshTokenController {
  final AuthRepositoryImpl _authRepository;
  final SecureStorageSource _secureStorageSource;

  RefreshTokenController({
    required AuthRepositoryImpl authRepository,
    required SecureStorageSource secureStorageSource,
  })  : _authRepository = authRepository,
        _secureStorageSource = secureStorageSource;
  bool _is401Already = false;
  int i = 0;
  Future<void> updateToken({required VoidCallback callback}) async {
    try {
      final accessToken = await _secureStorageSource.getUserData(
          type: StorageDataType.accessToken);
      i++;
      log('i $i');
      if (accessToken != null) {
        if (_is401Already) {
          log('LOGOUT');
          await _secureStorageSource.removeAllUserData();
          await navigatorKey.currentState?.pushNamedAndRemoveUntil(
            Pages.signIn.type,
            (route) => false,
          );
        } else {
          _is401Already = true;
          log('_is401Already $_is401Already');
          final model = await _authRepository.refreshToken();
          await _secureStorageSource.saveData(
            type: StorageDataType.accessToken,
            value: model.accessToken,
          );
          await _secureStorageSource.saveData(
            type: StorageDataType.refreshToken,
            value: model.refreshToken,
          );
          log('updated');
          callback();
        }
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
