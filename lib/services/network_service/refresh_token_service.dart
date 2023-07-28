import 'package:flutter/material.dart';
import 'package:todo2/data/repository/auth_repository_impl.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class RefreshTokenService {
  final AuthRepositoryImpl _authRepository;
  final SecureStorageSource _secureStorageSource;

  RefreshTokenService({
    required AuthRepositoryImpl authRepository,
    required SecureStorageSource secureStorageSource,
  })  : _authRepository = authRepository,
        _secureStorageSource = secureStorageSource;

  bool _is401ErrorAlready = false;

  Future<void> updateToken({required VoidCallback callback}) async {
    final accessToken = await _secureStorageSource.getUserData(
        type: StorageDataType.accessToken);
    if (accessToken != null) {
      if (_is401ErrorAlready) {
        await _secureStorageSource.removeAllUserData();
        _is401ErrorAlready = false;
        await navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Pages.signIn.type,
          (_) => false,
        );
      } else {
        _is401ErrorAlready = true;

        final model = await _authRepository.refreshToken();
        await _secureStorageSource.saveData(
          type: StorageDataType.accessToken,
          value: model.accessToken,
        );
        await _secureStorageSource.saveData(
          type: StorageDataType.refreshToken,
          value: model.refreshToken,
        );

        callback();
      }
    }
  }
}
