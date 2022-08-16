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
  static final SecureStorageSource _instance = SecureStorageSource._internal();

  factory SecureStorageSource() {
    return _instance;
  }
  SecureStorageSource._internal();

  final SecureStorageService _storage = SecureStorageService();
  SecureStorageService get storageApi => _storage;
}

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<String?> getUserData({required StorageDataType type}) async {
    try {
      String? data;
      switch (type) {
        case StorageDataType.id:
          data = await _storage.read(key: AuthScheme.userId);
          break;
        case StorageDataType.email:
          data = await _storage.read(key: AuthScheme.email);
          break;
        case StorageDataType.password:
          data = await _storage.read(key: AuthScheme.password);
          break;
        case StorageDataType.accessToken:
          data = await _storage.read(key: AuthScheme.accessToken);
          break;
        case StorageDataType.username:
          data = await _storage.read(key: AuthScheme.username);
          break;
        case StorageDataType.refreshToken:
          data = await _storage.read(key: AuthScheme.refreshToken);
          break;
        case StorageDataType.avatarUrl:
          data = await _storage.read(key: AuthScheme.avatarUrl);
          break;
      }

      return data;
    } catch (e) {
      debugPrint('secure storage error: $e');
    }
  }

  Future<void> saveUserData(
      {required StorageDataType type, required String value}) async {
    try {
      switch (type) {
        case StorageDataType.id:
          await _storage.write(key: AuthScheme.userId, value: value);
          break;
        case StorageDataType.email:
          await _storage.write(key: AuthScheme.email, value: value);
          break;
        case StorageDataType.password:
          await _storage.write(key: AuthScheme.password, value: value);
          break;
        case StorageDataType.accessToken:
          await _storage.write(key: AuthScheme.accessToken, value: value);
          break;

        case StorageDataType.username:
          await _storage.write(key: AuthScheme.username, value: value);
          break;
        case StorageDataType.refreshToken:
          await _storage.write(key: AuthScheme.refreshToken, value: value);
          break;
        case StorageDataType.avatarUrl:
          await _storage.write(key: AuthScheme.avatarUrl, value: value);
          break;
        default:
      }
    } catch (e, t) {
      debugPrint('secure storage error: $e, $t');
    }
  }

  Future<void> removeAllUserData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
