import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/database/database_scheme/env_scheme.dart';
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
    baseUrl: dotenv.env[EnvScheme.apiUrl] ?? 'null',
    connectTimeout: 5 * 1000, // 5 sec
    receiveTimeout: 5 * 1000,
  ))
    ..interceptors
        .add(InterceptorsWrapper(onResponse: (response, handler) async {
      if (response.statusCode == 401) {
        await UpdateTokenService().updateToken();
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

//   Future<Response<dynamic>> dioGet({required String path}) async {
//     return dio.get(path);
//   }

//   Future<Response<dynamic>> dioPut({required String path}) async {
//     return dio.put(path);
//   }
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
