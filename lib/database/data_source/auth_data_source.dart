import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/network_service/error_network/network_error_service.dart';

import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class AuthDataSource {
  Future<BaseResponse<AuthModel>> signUp({
    required String email,
    required String password,
    required String nickname,
  });
  Future<BaseResponse<AuthModel>> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<BaseResponse<AuthModel>> refreshToken();
}

class AuthDataSourceImpl implements AuthDataSource {
  final SecureStorageService _secureStorageService;
  AuthDataSourceImpl({required SecureStorageService secureStorageService})
      : _secureStorageService = secureStorageService;

  final _network = NetworkSource().networkApiClient;

  final _signInUrl = '/sign-in';
  final _signUpUrl = '/sign-up';
  final _signOutUrl = '/sign-out';
  final _refreshUrl = '/refresh-token';

  @override
  Future<BaseResponse<AuthModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _network.dio.post(
        _signInUrl,
        data: {
          AuthScheme.email: email,
          AuthScheme.password: password,
        },
        options: _network.authOptions,
      );
      final baseResponse = BaseResponse<AuthModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) =>
            AuthModel.fromJson(json: json, response: response),
        response: response,
      );
      log('baseResponse signIn: ${baseResponse.model.userId}');
      return baseResponse;
    } catch (e) {
      ErrorService.printError('Error in signIn() dataSource: $e');
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
      Response response = await _network.dio.post(
        _signUpUrl,
        data: {
          AuthScheme.email: email,
          AuthScheme.password: password,
          AuthScheme.username: nickname,
        },
        options: _network.authOptions,
      );
      final baseResponse = BaseResponse<AuthModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) =>
            AuthModel.fromJson(json: json, response: response),
        response: response,
      );

      return baseResponse;
    } catch (e) {
      ErrorService.printError('Error in signUp() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AuthModel>> refreshToken() async {
    try {
      Response response = await _network.dio.post(
        _refreshUrl,
        data: {
          AuthScheme.refreshToken: await _secureStorageService.getUserData(
              type: StorageDataType.refreshToken),
        },
        options: _network.authOptions,
      );

      final baseResponse = BaseResponse<AuthModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) =>
            AuthModel.fromJson(json: json, response: response),
        response: response,
      );

      return baseResponse;
    } catch (e) {
      ErrorService.printError('Error in refreshToken() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final response = await _network.dio.post(
        _signOutUrl,
        data: {
          AuthScheme.email: await _secureStorageService.getUserData(
              type: StorageDataType.email)
        },
        options: _network.authOptions,
      );
      await _secureStorageService.removeAllUserData();
      log('sign out ${response.data.toString()}');
    } catch (e) {
      ErrorService.printError('Error in signOut() dataSource: $e');
      rethrow;
    }
  }
}
