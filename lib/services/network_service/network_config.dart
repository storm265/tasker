import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/data/data_source/auth/auth_data_source_impl.dart';
import 'package:todo2/data/repository/auth_repository_impl.dart';
import 'package:todo2/schemas/database_scheme/env_scheme.dart';
import 'package:todo2/services/network_service/refresh_token_service.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';

const _contentType = 'Content-Type';
const _authorization = 'Authorization';
const _jsonApp = 'application/json';
const _multipartForm = 'multipart/form-data';

class NetworkSource {
  static final NetworkSource _instance = NetworkSource._internal();

  factory NetworkSource() {
    return _instance;
  }
  NetworkSource._internal();

  final String _tokenType = 'Bearer';

  final _storageSource = SecureStorageSource().storageApi;

  final Options authOptions = Options(
    validateStatus: (_) => true,
    headers: {
      _contentType: _jsonApp,
    },
  );

  static final _refreshTokenService = RefreshTokenService(
    authRepository: AuthRepositoryImpl(
      authDataSource: AuthDataSourceImpl(
        network: NetworkSource(),
        secureStorageService: SecureStorageSource(),
      ),
    ),
    secureStorageSource: SecureStorageSource(),
  );

  static final Dio _dio = Dio(BaseOptions(
    // TODO set up your api url
    baseUrl: dotenv.env[EnvScheme.apiUrl] ?? 'null',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ))
    ..interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          if (response.statusCode == 401) {
            await _refreshTokenService.updateToken(
              callback: () async => handler.resolve(
                await _retry(response.requestOptions),
              ),
            );
          }

          return handler.next(response);
        },
      ),
    );

  Future<Response<dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

  Future<Response<dynamic>> put({
    required String path,
    Map<String, dynamic>? data,
    Options? options,
  }) =>
      _dio.put(
        path,
        data: data,
        options: options,
      );

  Future<Response<dynamic>> post({
    required String path,
    dynamic data,
    Options? options,
    FormData? formData,
    bool isFormData = false,
  }) =>
      _dio.post(
        path,
        data: isFormData ? formData : data,
        options: options,
      );

  Future<Response<dynamic>> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) =>
      _dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );

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
  }) =>
      Options(
        validateStatus: (_) => true,
        headers: {
          _authorization: '$_tokenType $accessToken',
          useContentType ? _contentType : _jsonApp: null,
          useMultiPart ? _multipartForm : _jsonApp: null,
        },
      );

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
