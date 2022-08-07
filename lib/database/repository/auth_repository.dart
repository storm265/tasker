import 'package:dio/dio.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class AuthRepository {
  Future signUp({
    required String email,
    required String password,
    required String nickname,
  });

  Future signIn({
    required String email,
    required String password,
  });

  Future signOut();
  Future refreshToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl(
    secureStorageService: SecureStorageService(),
  );

  @override
  Future<BaseResponse<AuthModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDataSource.signIn(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in AuthRepositoryImpl signIn(): $e');
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AuthModel>> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      final response = await _authDataSource.signUp(
        email: email,
        password: password,
        nickname: nickname,
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in AuthRepositoryImpl signUp(): $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> signOut() async {
    try {
      final response = await _authDataSource.signOut();
      return response;
    } catch (e) {
      ErrorService.printError('Error in AuthRepositoryImpl signOut(): $e');
      rethrow;
    }
  }

  @override
  Future<String> refreshToken() async {
    try {
      final response = await _authDataSource.refreshToken();
      return response.model.refreshToken;
    } catch (e) {
      ErrorService.printError('Error in AuthRepositoryImpl refreshToken(): $e');
      rethrow;
    }
  }
}
