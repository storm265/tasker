import 'dart:developer';

import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';

import 'package:todo2/storage/secure_storage_service.dart';

abstract class AuthRepository {
  Future<AuthModel> signUp({
    required String email,
    required String password,
    required String nickname,
  });

  Future<AuthModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
  Future<AuthModel> refreshToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl(
    network: NetworkSource(),
    secureStorageService: SecureStorageService(),
  );

  @override
  Future<AuthModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDataSource.signIn(
        email: email,
        password: password,
      );
      return AuthModel.fromJson(json: response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<AuthModel> signUp({
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
      return AuthModel.fromJson(
        json: response,
        isSignUp: true,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<AuthModel> refreshToken() async {
    try {
      final response = await _authDataSource.refreshToken();
      log('refreshToken model $response');
      return AuthModel.fromJson(json: response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authDataSource.signOut();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
