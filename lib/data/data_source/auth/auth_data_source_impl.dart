import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:todo2/data/data_source/auth/auth_data_source.dart';
import 'package:todo2/schemas/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({
    required SecureStorageSource secureStorageService,
    required NetworkSource network,
  })  : _secureStorageService = secureStorageService,
        _networkSource = network;

  final SecureStorageSource _secureStorageService;

  final NetworkSource _networkSource;

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
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
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
  }

  @override
  Future<Map<String, dynamic>> refreshToken() async {
    final refreshToken = await _secureStorageService.getUserData(
      type: StorageDataType.refreshToken,
    );
    Response response = await _networkSource.post(
      path: _refreshUrl,
      data: {
        AuthScheme.refreshToken: refreshToken,
      },
      options: _networkSource.authOptions,
    );

    return NetworkErrorService.isSuccessful(response)
        ? response.data[AuthScheme.data] as Map<String, dynamic>
        : throw Failure(
            'Error: ${response.data[AuthScheme.data][AuthScheme.message]}',
          );
  }

  @override
  Future<void> signOut() async {
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
  }
}
