import 'package:todo2/storage/secure_storage_service.dart';

mixin AccessTokenMixin {
  final _secureStorage = SecureStorageSource();

  Future<Map<String, String>> getAccessHeader() async {
    final accessToken =
        await _secureStorage.getUserData(type: StorageDataType.accessToken) ??
            '';
    return {'Authorization': 'Bearer $accessToken'};
  }
}
