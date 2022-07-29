import 'dart:developer';

import 'package:dio/dio.dart';
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

class NetworkConfiguration {
  final Dio dio = Dio()
    ..options.baseUrl = 'https://todolist.dev2.cogniteq.com/api/v1'
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      print(" Upload Resposne 1 ${options.data}");
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print(" Upload Resposne 2 ${response.statusCode}");
      print(" Upload Resposne 2 ${response.data}");
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      // Do something with response error
      print(" Upload Resposne 12 ${e.error}");
      return handler.next(e); //continue
    }));
    
  final String tokenType = 'Bearer';

  final Options authOptions = Options(
    validateStatus: (_) => true,
    headers: {
      'Content-Type': 'application/json',
    },
  );
  final _storageSource = SecureStorageSource().storageApi;

  Future<Options> getLocalRequestOptions({bool useContentType = false}) async {
    return Options(
      validateStatus: (_) => true,
      headers: {
        'Authorization':
            '$tokenType ${await _storageSource.getUserData(type: StorageDataType.accessToken)}',
        useContentType ? 'Content-Type' : 'application/json': null,
      },
    );
  }

  Options getRequestOptions(
      {required String accessToken, bool useContentType = false}) {
    return Options(
      validateStatus: (_) => true,
      headers: {
        'Authorization': '$tokenType $accessToken',
        useContentType ? 'Content-Type' : 'application/json': null,
      },
    );
  }
}
