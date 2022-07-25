import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';
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
}

class AuthDataSourceImpl implements AuthDataSource {
  final SecureStorageService secureStorageService;
  AuthDataSourceImpl({required this.secureStorageService});

  final _network = NetworkSource().networkApiClient;

  @override
  Future<Response<dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _network.dio.post(
        '/sign-in',
        data: {
          AuthScheme.email: email,
          AuthScheme.password: password,
        },
        options: _network.authOptions,
      );

      return response;
    } catch (e) {
      ErrorService.printError('Error in signIn() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> signOut() async {
    try {
      Response response = await _network.dio.post(
        '/sign-out',
        // TODO fix it
        data: {AuthScheme.email: 'peter4533@mail.ru'},
        options: _network.authOptions,
      );
      await secureStorageService.removeAllUserData();
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
        '/sign-up',
        data: {
          AuthScheme.email: email,
          AuthScheme.password: password,
          AuthScheme.username: nickname,
        },
        options: _network.authOptions,
      );
      print('AuthDataSourceImpl data signUp : ${response.data}');
      print('AuthDataSourceImpl statusCode signUp : ${response.statusCode}');
      return response;
    } catch (e) {
      ErrorService.printError('Error in signUp() dataSource: $e');
      rethrow;
    }
  }
}
