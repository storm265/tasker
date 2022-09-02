import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';

enum StorageDataType {
  email,
  password,
  username,
  accessToken,
  refreshToken,
  id,
  avatarUrl,
}

class SecureStorageSource {
  static final SecureStorageSource _storage = SecureStorageSource._internal();

  factory SecureStorageSource() {
    return _storage;
  }
  SecureStorageSource._internal();

  SecureStorageSource get storageApi => _storage;

  final _secureStorage = const FlutterSecureStorage();

  // TODO: I suggest to split this huge method into a lot of smalls with perfect names
  Future<String?> getUserData({required StorageDataType type}) async {
    try {
      String? data;
      switch (type) {
        case StorageDataType.id:
          // TODO: it makes sense to use StorageDataType.dart instead of AuthScheme.dart by technical and sense reasons.
          data = await _secureStorage.read(key: AuthScheme.userId);
          break;
        case StorageDataType.email:
          data = await _secureStorage.read(key: AuthScheme.email);
          break;
        case StorageDataType.password:
          data = await _secureStorage.read(key: AuthScheme.password);
          break;
        case StorageDataType.accessToken:
          data = await _secureStorage.read(key: AuthScheme.accessToken);
          break;
        case StorageDataType.username:
          data = await _secureStorage.read(key: AuthScheme.username);
          break;
        case StorageDataType.refreshToken:
          data = await _secureStorage.read(key: AuthScheme.refreshToken);
          break;
        case StorageDataType.avatarUrl:
          data = await _secureStorage.read(key: AuthScheme.avatarUrl);
          break;
      }

      return data;
    } catch (e) {
      debugPrint('secure storage error: $e');
      throw 'Secure storage error';
    }
  }

  Future<void> saveUserData({
    required StorageDataType type,
    required String value,
  }) async {
    try {
      switch (type) {
        case StorageDataType.id:
          await _secureStorage.write(
            key: AuthScheme.userId,
            value: value,
          );
          break;
        case StorageDataType.email:
          await _secureStorage.write(
            key: AuthScheme.email,
            value: value,
          );
          break;
        case StorageDataType.password:
          await _secureStorage.write(
            key: AuthScheme.password,
            value: value,
          );
          break;
        case StorageDataType.accessToken:
          await _secureStorage.write(
            key: AuthScheme.accessToken,
            value: value,
          );
          break;

        case StorageDataType.username:
          await _secureStorage.write(
            key: AuthScheme.username,
            value: value,
          );
          break;
        case StorageDataType.refreshToken:
          await _secureStorage.write(
            key: AuthScheme.refreshToken,
            value: value,
          );
          break;
        case StorageDataType.avatarUrl:
          await _secureStorage.write(
            key: AuthScheme.avatarUrl,
            value: value,
          );
          break;
        default:
      }
    } catch (e, t) {
      debugPrint('secure storage error: $e, $t');
    }
  }

  Future<void> removeAllUserData() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
