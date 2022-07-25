import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

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
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl();

  @override
  Future<Response<dynamic>> signIn({
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
  Future<Response<dynamic>> signUp({
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
}
