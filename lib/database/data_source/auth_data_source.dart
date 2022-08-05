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

class AuthDataSourceImpl implements AuthDataSource {
  final NetworkErrorService _networkErrorService;
  final SecureStorageService _secureStorageService;
  AuthDataSourceImpl(
      {required SecureStorageService secureStorageService,
      required NetworkErrorService networkErrorService})
      : _secureStorageService = secureStorageService,
        _networkErrorService = networkErrorService;

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

      log('signIn response ${response.data}');

      final baseResponse = BaseResponse<AuthModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) => AuthModel.fromJson(json),
        errorService: _networkErrorService,
        response: response,
      );
      log('base response ${baseResponse.model}');

      return baseResponse;
    } catch (e) {
      ErrorService.printError('Error in signIn() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> signOut() async {
    try {
      Response response = await _network.dio.post(
        _signOutUrl,
        data: {
          AuthScheme.email: await _secureStorageService.getUserData(
              type: StorageDataType.email)
        },
        options: _network.authOptions,
      );
      await _secureStorageService.removeAllUserData();
      return response;
    } catch (e) {
      ErrorService.printError('Error in signOut() dataSource: $e');
      rethrow;
    }
  }

// TODo fix it
  @override
  Future<Response<dynamic>> signUp({
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
      return response;
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
          AuthScheme.refreshToken: _secureStorageService.getUserData(
              type: StorageDataType.refreshToken),
        },
        options: _network.authOptions,
      );

      final baseResponse = BaseResponse<AuthModel>.fromJson(
        json: response.data,
        build: (Map<String, dynamic> json) => AuthModel.fromJson(json),
        errorService: _networkErrorService,
        response: response,
      );

      return baseResponse;
    } catch (e) {
      ErrorService.printError('Error in refreshToken() dataSource: $e');
      rethrow;
    }
  }
}
