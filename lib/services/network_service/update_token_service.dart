import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class UpdateTokenService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final AuthDataSourceImpl _authRepository = AuthDataSourceImpl(
    secureStorageService: SecureStorageService(),
  );

  Future<void> updateToken({required Response response}) async {
    try {
      final expiresAt = DateTime.fromMillisecondsSinceEpoch(
          response.data[AuthScheme.data].expiresIn);

      log('Time now: ${DateTime.now()}');
      log('expiresAt: $expiresAt');
      if (DateTime.now().isAfter(expiresAt)) {
        log('*** Token is expired *** ');
        final authResponse = await _authRepository.refreshToken();
        await _secureStorageService.saveUserData(
            type: StorageDataType.refreshToken,
            value: authResponse.model.refreshToken);
        log('*** Token updated *** ');
      }
    } catch (e) {
      ErrorService.printError('Update token error $e');
    }
  }
}
