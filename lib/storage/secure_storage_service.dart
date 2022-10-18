import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StorageDataType {
  email('email'),
  password('password'),
  username('username'),
  accessToken('accessToken'),
  refreshToken('refreshToken'),
  id('id'),
  avatarUrl('avatarUrl');

  final String type;
  const StorageDataType(this.type);
}

class SecureStorageSource {
  static final SecureStorageSource _storage = SecureStorageSource._internal();

  factory SecureStorageSource() {
    return _storage;
  }
  SecureStorageSource._internal();

  SecureStorageSource get storageApi => _storage;

  final _secureStorage = const FlutterSecureStorage();

  Future<void> removeAllUserData() async => await _secureStorage.deleteAll();

  Future<String?> getUserData({required StorageDataType type}) async {
    String? data;
    switch (type) {
      case StorageDataType.id:
        data = await _secureStorage.read(key: StorageDataType.id.type);
        break;
      case StorageDataType.email:
        data = await _secureStorage.read(key: StorageDataType.email.type);
        break;
      case StorageDataType.password:
        data = await _secureStorage.read(key: StorageDataType.password.type);
        break;
      case StorageDataType.accessToken:
        data = await _secureStorage.read(key: StorageDataType.accessToken.type);
        break;
      case StorageDataType.username:
        data = await _secureStorage.read(key: StorageDataType.username.type);
        break;
      case StorageDataType.refreshToken:
        data =
            await _secureStorage.read(key: StorageDataType.refreshToken.type);
        break;
      case StorageDataType.avatarUrl:
        data = await _secureStorage.read(key: StorageDataType.avatarUrl.type);
        break;
    }
    return data;
  }

  Future<void> saveData({
    required StorageDataType type,
    required String value,
  }) async {
    switch (type) {
      case StorageDataType.id:
        await _secureStorage.write(
          key: StorageDataType.id.type,
          value: value,
        );
        break;
      case StorageDataType.email:
        await _secureStorage.write(
          key: StorageDataType.email.type,
          value: value,
        );
        break;
      case StorageDataType.password:
        await _secureStorage.write(
          key: StorageDataType.password.type,
          value: value,
        );
        break;
      case StorageDataType.accessToken:
        await _secureStorage.write(
          key: StorageDataType.accessToken.type,
          value: value,
        );
        break;
      case StorageDataType.username:
        await _secureStorage.write(
          key: StorageDataType.username.type,
          value: value,
        );
        break;
      case StorageDataType.refreshToken:
        await _secureStorage.write(
          key: StorageDataType.refreshToken.type,
          value: value,
        );
        break;
      case StorageDataType.avatarUrl:
        await _secureStorage.write(
          key: StorageDataType.avatarUrl.type,
          value: value,
        );
        break;
    }
  }
}
