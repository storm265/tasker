import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';

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

  Future<String?> getAccessToken() async {
    try {
      String? accessToken = await _storage.read(key: AuthScheme.accessToken);
      return accessToken;
    } catch (e) {
      ErrorService.printError('SecureStorageService getAccessToken error: $e');
      rethrow;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      String? refreshToken = await _storage.read(key: AuthScheme.refreshToken);
      return refreshToken;
    } catch (e) {
      ErrorService.printError('SecureStorageService getRefreshToken error: $e');
      rethrow;
    }
  }

  Future<String?> getEmail() async {
    try {
      String? email = await _storage.read(key: AuthScheme.email);
      return email;
    } catch (e) {
      ErrorService.printError('SecureStorageService getEmail error: $e');
      rethrow;
    }
  }

  Future<String?> getPassword() async {
    try {
      String? password = await _storage.read(key: AuthScheme.password);
      return password;
    } catch (e) {
      ErrorService.printError('SecureStorageService getPassword error: $e');
      rethrow;
    }
  }

  Future<String?> getId() async {
    try {
      String? id = await _storage.read(key: AuthScheme.id);
      return id;
    } catch (e) {
      ErrorService.printError('SecureStorageService getUsername error: $e');
      rethrow;
    }
  }

  Future<String?> getUsername() async {
    try {
      String? username = await _storage.read(key: AuthScheme.username);
      return username;
    } catch (e) {
      ErrorService.printError('SecureStorageService getUsername error: $e');
      rethrow;
    }
  }

  Future<void> putUserData({
    required String email,
    required String password,
    required String username,
    required String refreshToken,
    required String accessToken,
    required String id,
  }) async {
    try {
      await _storage.write(key: AuthScheme.id, value: id);
      await _storage.write(key: AuthScheme.email, value: email);
      await _storage.write(key: AuthScheme.password, value: password);
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
