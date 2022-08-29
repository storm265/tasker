import 'dart:developer';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/refresh_token_controller.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class UpdateTokenService {
  static final SecureStorageService _secureStorageService =
      SecureStorageService();
  static final RefreshTokenController refreshTokenController =
      RefreshTokenController(
    authRepository: AuthRepositoryImpl(),
  );

  static Future<void> updateToken() async {
    try {
      final String? token = await _secureStorageService.getUserData(
          type: StorageDataType.accessToken);

      log('*** Token is expired *** ');

      // final authResponse = await refreshTokenController.updateToken();
      // log('update status ${authResponse}');
      // await _secureStorageService.saveUserData(
      //     type: StorageDataType.refreshToken,
      //     value: authResponse.refreshToken);
      // await _secureStorageService.saveUserData(
      //     type: StorageDataType.accessToken, value: authResponse.accessToken);

    } catch (e, t) {
      log('Update token error: $e,$t');
      throw Exception('Update token error: $e');
    }
  }
}
