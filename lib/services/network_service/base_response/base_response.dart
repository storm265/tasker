import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/network_service/error_network/network_error_service.dart';

// bad
final _errorService = NetworkErrorService();

class BaseResponse<T> {
  T model;

  BaseResponse({required this.model});

  factory BaseResponse.fromJson({
    required Map<String, dynamic> json,
    required Function(Map<String, dynamic> json) build,
    required Response response,
  }) {
    _errorService.isError(response: response)
        ? MessageService.displaySnackbar(
            message: 'Error ${response.statusCode}: ${response.statusMessage}')
        : null;
    return BaseResponse<T>(
      model: build(json[AuthScheme.data]),
    );
  }
}

class BaseListResponse<T> {
  List<T>? model;

  BaseListResponse({
    required this.model,
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
        model: build(json[AuthScheme.data]),
      );
    }
  }
}
