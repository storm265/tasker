import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo2/services/error_service/error_service.dart';

class TokenStorageSource {
  static final TokenStorageSource _instance = TokenStorageSource._internal();

  factory TokenStorageSource() {
    return _instance;
  }
  TokenStorageSource._internal();

  final TokenStorageService _storage = TokenStorageService();
  TokenStorageService get storageApi => _storage;
}

class TokenStorageService {
  final _storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    try {
      String? refreshToken = await _storage.read(key: 'refreshToken');
      return refreshToken;
    } catch (e) {
      ErrorService.printError('TokenStorageService readRefreshToken error: $e');
      rethrow;
    }
  }

  Future<void> putTokens(
      {required String refreshToken, required String accessToken}) async {
    try {
      await _storage.write(key: 'accessToken', value: accessToken);
      await _storage.write(key: 'refreshToken', value: refreshToken);
    } catch (e) {
      ErrorService.printError('TokenStorageService readRefreshToken error: $e');
      rethrow;
    }
  }

  Future<void> removeAllTokens() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      ErrorService.printError('TokenStorageService removeAllTokens error: $e');
      rethrow;
    }
  }
}
