import 'dart:developer';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class UpdateTokenService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final AuthDataSourceImpl _authRepository = AuthDataSourceImpl(
    secureStorageService: SecureStorageService(),
  );

  Future<void> updateToken() async {
    try {
      log('*** Token is expired *** ');
      log('refresj token :   ${await _secureStorageService.getUserData(type: StorageDataType.refreshToken)} ');

      // final authResponse = await _authRepository.refreshToken();
      // await _secureStorageService.saveUserData(
      //     type: StorageDataType.refreshToken,
      //     value: authResponse.model.refreshToken);
      // await _secureStorageService.saveUserData(
      //     type: StorageDataType.accessToken,
      //     value: authResponse.model.accessToken);
    } catch (e, t) {
      ErrorService.printError('Update token error $e, $t');
    }
  }
}
