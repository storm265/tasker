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

  Future<void> saveAvatarUrl({required String avatarUrl}) async {
    try {
      await _storage.write(key: AuthScheme.avatarUrl, value: avatarUrl);
    } catch (e) {
      ErrorService.printError('SecureStorageService putAvatarUrl error: $e');
      rethrow;
    }
  }

  Future<void> saveUserData({
    required String id,
    required String email,
    required String username,
    required String refreshToken,
    required String accessToken,
  }) async {
    try {
      await _storage.write(key: AuthScheme.userId, value: id);
      await _storage.write(key: AuthScheme.email, value: email);
      await _storage.write(key: AuthScheme.username, value: username);
      await _storage.write(key: AuthScheme.accessToken, value: accessToken);
      await _storage.write(key: AuthScheme.refreshToken, value: refreshToken);
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
