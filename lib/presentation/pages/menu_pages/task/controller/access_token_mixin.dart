import 'package:todo2/services/secure_storage_service.dart';

mixin AccessTokenMixin {

  Future<Map<String, String>> getAccessHeader(SecureStorageSource secureStorage) async {
    final accessToken =
        await secureStorage.getUserData(type: StorageDataType.accessToken) ??
            '';
    return {'Authorization': 'Bearer $accessToken'};
  }
}
