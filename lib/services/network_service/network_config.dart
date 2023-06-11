import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/data/data_source/auth/auth_data_source_impl.dart';
import 'package:todo2/database/database_scheme/env_scheme.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/network_service/refresh_token_controller.dart';
import 'package:todo2/services/secure_storage_service.dart';

const _contentType = 'Content-Type';
const _authorization = 'Authorization';
const _jsonApp = 'application/json';
const _multipartForm = 'multipart/form-data';

final _refreshToken = RefreshTokenController(
  authRepository: AuthRepositoryImpl(
    authDataSource: AuthDataSourceImpl(
      network: NetworkSource(),
      secureStorageService: SecureStorageSource(),
    ),
  ),
  secureStorageSource: SecureStorageSource(),
);

class NetworkSource {
  static final NetworkSource _instance = NetworkSource._internal();

  factory NetworkSource() {
    return _instance;
  }
  NetworkSource._internal();

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env[EnvScheme.apiUrl] ?? 'null',
    connectTimeout: 5 * 1000, // 5 sec
    receiveTimeout: 5 * 1000,
  ))
    ..interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          if (response.statusCode == 401) {
            await _refreshToken.updateToken(
              callback: () async => handler.resolve(
                await _retry(response.requestOptions),
              ),
            );
          }

          return handler.next(response);
        },
      ),
    );

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
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    return _dio.delete(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  Future<Options> getLocalRequestOptions({bool useContentType = false}) async {
    final accessToken =
        await _storageSource.getUserData(type: StorageDataType.accessToken) ??
            '';
    return Options(
      validateStatus: (_) => true,
      headers: {
        _authorization: '$_tokenType $accessToken',
        useContentType ? _contentType : _jsonApp: null,
      },
    );
  }

  Options getRequestOptions({
    required String accessToken,
    bool useMultiPart = false,
    bool useContentType = false,
  }) {
    return Options(
      validateStatus: (_) => true,
      headers: {
        _authorization: '$_tokenType $accessToken',
        useContentType ? _contentType : _jsonApp: null,
        useMultiPart ? _multipartForm : _jsonApp: null,
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
