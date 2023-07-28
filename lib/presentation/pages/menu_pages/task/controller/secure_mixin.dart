import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';

mixin SecureMixin {
  Future<Map<String, String>> getAccessHeader(
      SecureStorageSource secureStorage) async {
    final accessToken =
        await secureStorage.getUserData(type: StorageDataType.accessToken) ??
            '';
    return {'Authorization': 'Bearer $accessToken'};
  }
}
