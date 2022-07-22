import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

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
  Future signOut({required String email});
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
        '${_network.serverUrl}/sign-in',
        data: {
          AuthScheme.email: email,
          AuthScheme.password: password,
        },
      ); print('AuthDataSourceImpl data signIn : ${response.data}');
       print('AuthDataSourceImpl statusCode signIn : ${response.statusCode}');
      return response;
    } catch (e) {
      ErrorService.printError('Error in signIn() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> signOut({required String email}) async {
    try {
      Response response = await _network.dio.post(
        '${_network.serverUrl}/sign-out',
        data: {AuthScheme.email: email},
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
        '${_network.serverUrl}/sign-up',
        data: {
          AuthScheme.email: email,
          AuthScheme.password: password,
          AuthScheme.nickname: nickname,
        },
      ); print('AuthDataSourceImpl data signUp : ${response.data}');
       print('AuthDataSourceImpl statusCode signUp : ${response.statusCode}');
      return response;
    } catch (e) {
      ErrorService.printError('Error in signUp() dataSource: $e');
      rethrow;
    }
  }
}
