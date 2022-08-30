import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/database/database_scheme/env_scheme.dart';
import 'package:todo2/services/network_service/update_token_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

const _contentType = 'Content-Type';
const _authorization = 'Authorization';
const _jsonApp = 'application/json';

class NetworkSource {
  static final NetworkSource _dioClient = NetworkSource._internal();

  factory NetworkSource() {
    return _dioClient;
  }

  NetworkSource._internal();

  NetworkSource get networkApiClient => _dioClient;

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env[EnvScheme.apiUrl] ?? 'null',
    connectTimeout: 5 * 1000, // 5 sec
    receiveTimeout: 5 * 1000,
  ))
    ..interceptors
        .add(InterceptorsWrapper(onResponse: (response, handler) async {
      return handler.next(response);
    }, onError: (DioError error, handler) async {
      log('error : ${error.error}');
      if (error.response!.statusCode == 401 &&
          error.response!.statusMessage ==
              "Token is not valid or has expired") {
        await UpdateTokenService.updateToken();
        // retry last operation
        return handler.resolve(await _retry(error.requestOptions));
      }

      log('error $error, handler $handler');
      return handler.next(error); //continue
    }));

  final String _tokenType = 'Bearer';

  final Options authOptions = Options(
    validateStatus: (_) => true,
    headers: {
      _contentType: _jsonApp,
    },
  );
  final _storageSource = SecureStorageSource().storageApi;

  Future<Response<dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> put({
    required String path,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    return _dio.put(
      path,
      data: data,
      options: options,
    );
  }

  Future<Response<dynamic>> post({
    required String path,
    dynamic data,
    Options? options,
    FormData? formData,
    bool isFormData = false,
  }) async {
    return _dio.post(
      path,
      data: isFormData ? formData : data,
      options: options,
    );
  }

  Future<Response<dynamic>> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Options> getLocalRequestOptions({bool useContentType = false}) async {
    return Options(
      validateStatus: (_) => true,
      headers: {
        _authorization:
            '$_tokenType ${await _storageSource.getUserData(type: StorageDataType.accessToken)}',
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
        _authorization: '$_tokenType $accessToken',
        useContentType ? _contentType : _jsonApp: null,
      },
    );
  }

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}

// TODO: you need to merge NetworkSource.dart and NetworkConfiguration.dart into one class
// TODO: add only GET, POST, etc public method with overloaded method signature to invoke them from Presentation layer.
// TODO: You should not show you internal implementation


//import 'package:dio/adapter.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:todo2/database/database_scheme/env_scheme.dart';
// import 'package:todo2/services/network_service/update_token_service.dart';
// import 'package:todo2/storage/secure_storage_service.dart';

// const _contentType = 'Content-Type';
// const _authorization = 'Authorization';
// const _jsonApp = 'application/json';

// class NetworkSource extends Dio{
//   static final NetworkSource _instance = NetworkSource._internal();

//   factory NetworkSource() {
//     return _instance;
//   }

//   NetworkSource._internal();

//   final NetworkSource _dioClient = NetworkSource();

//   NetworkSource get networkApiClient => _dioClient;

  // Future<Response<dynamic>> dioGet({required String path}) async {
  //   return dio.get(path);
  // }

  // Future<Response<dynamic>> dioPut({required String path}) async {
  //   return dio.put(path);
  // }
// // should be private
//   final Dio dio = Dio(BaseOptions(
//     baseUrl: dotenv.env[EnvScheme.apiUrl] ?? 'null',
//     connectTimeout: 5 * 1000, // 5 sec
//     receiveTimeout: 5 * 1000,
//   ))
//     ..interceptors
//         .add(InterceptorsWrapper(onResponse: (response, handler) async {
//       if (response.statusCode == 401) {
//         await UpdateTokenService().updateToken();
//       }

//       return handler.next(response); // continue
//     }, onError: (DioError e, handler) {
//       return handler.next(e); //continue
//     }));

//   final String tokenType = 'Bearer';

//   final Options authOptions = Options(
//     validateStatus: (_) => true,
//     headers: {
//       _contentType: _jsonApp,
//     },
//   );
//   final _storageSource = SecureStorageSource().storageApi;

//   Future<Options> getLocalRequestOptions({bool useContentType = false}) async {
//     return Options(
//       validateStatus: (_) => true,
//       headers: {
//         _authorization:
//             '$tokenType ${await _storageSource.getUserData(type: StorageDataType.accessToken)}',
//         useContentType ? _contentType : _jsonApp: null,
//       },
//     );
//   }

//   Options getRequestOptions({
//     required String accessToken,
//     bool useContentType = false,
//   }) {
//     return Options(
//       validateStatus: (_) => true,
//       headers: {
//         _authorization: '$tokenType $accessToken',
//         useContentType ? _contentType : _jsonApp: null,
//       },
//     );
//   }
// }

// // TODO: you need to merge NetworkSource.dart and NetworkConfiguration.dart into one class
// // TODO: add only GET, POST, etc public method with overloaded method signature to invoke them from Presentation layer.
// // TODO: You should not show you internal implementation
// class NetworkConfiguration {}
