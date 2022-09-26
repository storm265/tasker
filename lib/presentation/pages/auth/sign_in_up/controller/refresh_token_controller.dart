import 'dart:developer';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class RefreshTokenController {
  final SecureStorageSource _secureStorageService;
  final AuthRepositoryImpl _authRepository;

  
  RefreshTokenController({
    required AuthRepositoryImpl authRepository,
    required SecureStorageSource secureStorageService,
  })  : _authRepository = authRepository,
        _secureStorageService = secureStorageService;

  Future<void> updateToken() async {
    try {
      log('*** Token is expired *** ');
      final model = await _authRepository.refreshToken();
      log('model ${model.accessToken}');
      await _secureStorageService.saveUserData(
        type: StorageDataType.accessToken,
        value: model.accessToken,
      );
      await _secureStorageService.saveUserData(
        type: StorageDataType.refreshToken,
        value: model.refreshToken,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
