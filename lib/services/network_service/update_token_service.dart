import 'dart:developer';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class UpdateTokenService {
  static final SecureStorageSource _secureStorageService =
      SecureStorageSource();
  // static final RefreshTokenController refreshTokenController =
  //     RefreshTokenController(
  //   authRepository: AuthRepositoryImpl(),
  // );
  static final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
  static Future<void> updateToken() async {
    try {
      final token = await _secureStorageService.getUserData(
          type: StorageDataType.accessToken);
            final email = await _secureStorageService.getUserData(
          type: StorageDataType.email) ?? '';
            final password = await _secureStorageService.getUserData(
          type: StorageDataType.password) ?? '';
      if (token != null) {
        log('*** Token is expired *** ');
        // final authResponse = await refreshTokenController
        //     .updateToken()
        //     .whenComplete(() => log('done!'));
        final authResponse = await authRepositoryImpl.signIn(
            email: email, password: password);
        log('update status $authResponse');
        await _secureStorageService.saveUserData(
            type: StorageDataType.refreshToken,
            value: authResponse.refreshToken);
        await _secureStorageService.saveUserData(
            type: StorageDataType.accessToken, value: authResponse.accessToken);
      }
    } catch (e, t) {
      log('Update token error: $e,$t');
      throw Exception('Update token error: $e');
    }
  }
}
