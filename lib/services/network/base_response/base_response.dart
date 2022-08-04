import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/network/error_network/network_error_service.dart';

class BaseResponse<T> {
  Response response;
  T model;
  NetworkErrorService errorService;

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
  }) {
    if (errorService.isError(response: response)) {
      throw MessageService.displaySnackbar(
          message: 'Error ${response.statusCode}: ${response.statusMessage}');
    } else {
      return BaseResponse<T>(
        errorService: errorService,
        response: response,
        model: build(json[AuthScheme.data]),
      );
    }
  }
}

class BaseListResponse<T> {
  Response response;
  List<T>? model;
  NetworkErrorService errorService;

  BaseListResponse({
    required this.response,
    required this.model,
    required this.errorService,
  });
  factory BaseListResponse.fromJson({
    required Map<String, dynamic> json,
    required Function(Map<String, dynamic> json) build,
    required NetworkErrorService errorService,
    required Response response,
  }) {
    if (errorService.isError(response: response)) {
      throw MessageService.displaySnackbar(
          message: 'Error ${response.statusCode}: ${response.statusMessage}');
    } else {
      return BaseListResponse<T>(
        errorService: errorService,
        response: response,
        model: build(json[AuthScheme.data]),
      );
    }
  }
}
