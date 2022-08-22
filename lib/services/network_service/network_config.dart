import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:todo2/services/network_service/update_token_service.dart';

import 'package:todo2/storage/secure_storage_service.dart';

class NetworkSource {
  static final NetworkSource _instance = NetworkSource._internal();

  factory NetworkSource() {
    return _instance;
  }

  NetworkSource._internal();

  final NetworkConfiguration _dioClient = NetworkConfiguration();

  NetworkConfiguration get networkApiClient => _dioClient;
}

const _contentType = 'Content-Type';
const _authorization = 'Authorization';
const _jsonApp = 'application/json';

// TODO: you need to merge NetworkSource.dart and NetworkConfiguration.dart into one class
// TODO: add only GET, POST, etc public method with overloaded method signature to invoke them from Presentation layer.
// TODO: You should not show you internal implementation
class NetworkConfiguration {
  final Dio dio = Dio(BaseOptions(
    // TODO: move this String to a ENV/resource variable for secure reason
    baseUrl: 'https://todolist.dev2.cogniteq.com/api/v1',
    connectTimeout: 5 * 1000, // 5 sec
    receiveTimeout: 5 * 1000,
  ))
    ..interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      if (response.statusCode == 401) {
        // TODO: i guess, it should be async call???
        UpdateTokenService().updateToken();
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
