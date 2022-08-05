import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:todo2/services/network_service/update_token_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class NetworkSource {
  static final NetworkSource _instance = NetworkSource._internal();

  factory NetworkSource() {
    return _instance;
  }

  NetworkSource._internal();

  final NetworkConfiguration _supabaseClient = NetworkConfiguration();

  NetworkConfiguration get networkApiClient => _supabaseClient;
}

const _contentType = 'Content-Type';
const _authorization = 'Authorization';
const _jsonApp = 'application/json';

class NetworkConfiguration {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://todolist.dev2.cogniteq.com/api/v1',
    connectTimeout: 5 * 1000, // 5 sec
    receiveTimeout: 5 * 1000,
  ))
    ..interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      if (response.statusCode == 401) {
        log('NetworkConfiguration TOKEN EXPIRED');
        UpdateTokenService().updateToken(response: response);
      }

      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      return handler.next(e); //continue
    }));

  final String tokenType = 'Bearer';

  final Options authOptions = Options(
    validateStatus: (_) => true,
    headers: {
      _contentType: _jsonApp,
    },
  );
  final _storageSource = SecureStorageSource().storageApi;

  Future<Options> getLocalRequestOptions({bool useContentType = false}) async {
    return Options(
      validateStatus: (_) => true,
      headers: {
        _authorization:
            '$tokenType ${await _storageSource.getUserData(type: StorageDataType.accessToken)}',
        useContentType ? _contentType : _jsonApp: null,
      },
    );
  }

  Options getRequestOptions({
    required String accessToken,
    bool useContentType = false,
  }) {
    return Options(
      validateStatus: (_) => true,
      headers: {
        _authorization: '$tokenType $accessToken',
        useContentType ? _contentType : _jsonApp: null,
      },
    );
  }
}
