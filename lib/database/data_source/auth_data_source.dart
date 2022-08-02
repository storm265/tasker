import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/base_response/base_response.dart';
import 'package:todo2/services/network/constants.dart';
import 'package:todo2/services/network/error_network/network_error_service.dart';
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
    required BuildContext context,
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
  Future<Response> signIn({
    required String email,
    required String password,
    required BuildContext context,
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
      return response;
      // return BaseResponse(
      //   response: response,
      //   error: NetworkErrorService(),
      //   context: context,
      // ).isSuccessful();
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
  Future<Response<dynamic>> refreshToken() async {
    try {
      Response response = await _network.dio.post(
        _refreshUrl,
        data: {
          AuthScheme.refreshToken: _secureStorageService.getUserData(
              type: StorageDataType.refreshToken),
        },
        options: _network.authOptions,
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in refreshToken() dataSource: $e');
      rethrow;
    }
  }
}
