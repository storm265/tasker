import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

abstract class AuthDataSource {
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String nickname,
  });
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<Map<String, dynamic>> refreshToken();
}

class AuthDataSourceImpl implements AuthDataSource {
  final SecureStorageSource _secureStorageService;
  final NetworkSource _networkSource;

  AuthDataSourceImpl({
    required SecureStorageSource secureStorageService,
    required NetworkSource network,
  })  : _secureStorageService = secureStorageService,
        _networkSource = network;

  final _signInUrl = '/sign-in';
  final _signUpUrl = '/sign-up';
  final _signOutUrl = '/sign-out';
  final _refreshUrl = '/refresh-token';

  String _encodePassword(String text) {
    List<int> encodedText = utf8.encode(text);
    String base64Str = base64.encode(encodedText);
    return base64Str;
  }

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _networkSource.post(
        path: _signInUrl,
        data: {
          AuthScheme.email: email.toLowerCase(),
          AuthScheme.password: _encodePassword(password),
        },
        options: _networkSource.authOptions,
      );
      if (NetworkErrorService.isSuccessful(response)) {
        return response.data[AuthScheme.data] as Map<String, dynamic>;
      } else {
        throw Failure(
            'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      Response response = await _networkSource.post(
        path: _signUpUrl,
        data: {
          AuthScheme.email: email.toLowerCase(),
          AuthScheme.password: _encodePassword(password),
          AuthScheme.username: nickname,
        },
        options: _networkSource.authOptions,
      );
      return NetworkErrorService.isSuccessful(response)
          ? response.data[AuthScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> refreshToken() async {
    try {
      final refreshToken = await _secureStorageService.getUserData(
        type: StorageDataType.refreshToken,
      );
      final response = await _networkSource.post(
        path: _refreshUrl,
        data: {
          AuthScheme.refreshToken: refreshToken,
        },
        options: _networkSource.authOptions,
      );
      log('dataSource response ${response.data}');
      log('dataSource response ${response.data[AuthScheme.accessToken]}');
      log('dataSource response ${response.data[AuthScheme.refreshToken]}');
      return NetworkErrorService.isSuccessful(response)
          ? response.data[AuthScheme.data] as Map<String, dynamic>
          : throw Failure(
              'Error: ${response.data[AuthScheme.data][AuthScheme.message]}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _networkSource.post(
        path: _signOutUrl,
        data: {
          AuthScheme.email: await _secureStorageService.getUserData(
            type: StorageDataType.email,
          )
        },
        options: _networkSource.authOptions,
      );
      await _secureStorageService.removeAllUserData();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
