import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';

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
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 401) {
        log(' ERROR 401');
      }
      // print('AuthDataSourceImpl data signIn : ${response.data}');
      // print('AuthDataSourceImpl statusCode signIn : ${response.statusCode}');
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
      );
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
          AuthScheme.nickname: nickname,
        },
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
