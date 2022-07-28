import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';

enum StorageDataType {
  email,
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
      String? username;
      switch (type) {
        case StorageDataType.id:
          username = await _storage.read(key: AuthScheme.userId);
          break;
        case StorageDataType.email:
          username = await _storage.read(key: AuthScheme.email);
          break;
        case StorageDataType.accessToken:
          username = await _storage.read(key: AuthScheme.accessToken);
          break;

        case StorageDataType.username:
          username = await _storage.read(key: AuthScheme.username);
          break;
        case StorageDataType.refreshToken:
          username = await _storage.read(key: AuthScheme.refreshToken);
          break;
        case StorageDataType.avatarUrl:
          username = await _storage.read(key: AuthScheme.avatarUrl);
          break;
        default:
      }

      return username;
    } catch (e) {
      ErrorService.printError('SecureStorageService getUserData error: $e');
      rethrow;
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
    } catch (e) {
      ErrorService.printError('SecureStorageService putUserData error: $e');
      rethrow;
    }
  }

  Future<void> removeAllUserData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      ErrorService.printError(
          'SecureStorageService removeAllUserData error: $e');
      rethrow;
    }
  }
}
