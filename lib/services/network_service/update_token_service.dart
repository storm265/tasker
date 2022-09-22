import 'dart:developer';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/refresh_token_controller.dart';

class UpdateTokenService {
  static final RefreshTokenController refreshTokenController =
      RefreshTokenController(
    authRepository: AuthRepositoryImpl(),
  );

  Future<void> updateToken() async {
    try {
      log('*** Token is expired *** ');
      // final authResponse = await refreshTokenController
      //     .updateToken()
      //     .whenComplete(() => log('done!'));

      // log('update status $authResponse');
      // await _secureStorageService.saveUserData(
      //     type: StorageDataType.refreshToken,
      //     value: authResponse.refreshToken);
      // await _secureStorageService.saveUserData(
      //     type: StorageDataType.accessToken, value: authResponse.accessToken);

      await Future.delayed(const Duration(milliseconds: 3))
          .then((value) => log('updated1'));
      await Future.delayed(const Duration(milliseconds: 3))
          .then((value) => log('updated2'));
      await Future.delayed(const Duration(milliseconds: 3))
          .then((value) => log('updated3'));
      await Future.delayed(const Duration(milliseconds: 3))
          .then((value) => log('updated4'));
    } catch (e, t) {
      log('Update token error: $e,$t');
      throw Exception('Update token error: $e');
    }
  }
}
