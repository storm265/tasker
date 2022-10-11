import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

enum States {
  today,
  tomorrow,
}

abstract   class TaskItems {
  TaskModel model;

  States state;

  TaskItems(this.model, this.state);
}

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
    final accessToken = await _secureStorageSource.getUserData(
        type: StorageDataType.accessToken);
    if (accessToken != null) {
      if (_is401Already) {
        log('LOGOUT');
        await _secureStorageSource.removeAllUserData();
        _is401Already = false;
        await navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Pages.signIn.type,
          (_) => false,
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
  }
}
