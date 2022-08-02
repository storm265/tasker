import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/error_network/network_error_service.dart';
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
    required BuildContext context,
  });

  Future signOut();
  Future refreshToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl(
    secureStorageService: SecureStorageService(),
    networkErrorService: NetworkErrorService(),
  );

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await _authDataSource.signIn(
        context: context,
        email: email,
        password: password,
      );
      return response.data[AuthScheme.data];
    } catch (e) {
      ErrorService.printError('Error in AuthRepositoryImpl signIn(): $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> signUp({
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
      return response.data[AuthScheme.data];
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
  Future<Map<String, dynamic>> refreshToken() async {
    try {
      final response = await _authDataSource.refreshToken();
      return response.data[AuthScheme.data];
    } catch (e) {
      ErrorService.printError('Error in AuthRepositoryImpl refreshToken(): $e');
      rethrow;
    }
  }
}
