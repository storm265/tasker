import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/network/error_network/network_error_service.dart';

class BaseResponse<T> {
  Response response;
  T model;
  NetworkErrorService errorService;

  bool isSuccessful() {
    if (errorService.isError(response: response)) {
      return false;
    } else {
      return true;
    }
  }

  BaseResponse({
    required this.response,
    required this.model,
    required this.errorService,
  });
  factory BaseResponse.fromJson({
    required Map<String, dynamic> json,
    required Function(Map<String, dynamic> json) build,
    required NetworkErrorService errorService,
    required Response response,
  }) =>
      BaseResponse<T>(
        errorService: errorService,
        response: response,
        model: build(json[AuthScheme.data]),
      );
}



class BaseListResponse<T> {
  Response response;
  List<T>? data;
  NetworkErrorService errorService;

  bool isSuccessful() {
    if (errorService.isError(response: response)) {
      return false;
    } else {
      return true;
    }
  }

  BaseListResponse({
    required this.response,
    required this.data,
    required this.errorService,
  });
  factory BaseListResponse.fromJson({
    required Map<String, dynamic> json,
    required Function(Map<String, dynamic> json) build,
    required NetworkErrorService errorService,
    required Response response,
  }) =>
      BaseListResponse<T>(
        errorService: errorService,
        response: response,
        data: build(json[AuthScheme.data]),
      );
}