import 'package:dio/dio.dart';
import 'package:todo2/services/network/error_network/network_error_service.dart';

abstract class BaseResponse<T> {
  T response;
  NetworkErrorService error;

  BaseResponse({required this.response, required this.error});

  dynamic isSuccessful();
}

class MyClass extends BaseResponse<Response> {
  MyClass({required Response response, required NetworkErrorService error})
      : super(response: response, error: error);

  @override
  dynamic isSuccessful() {
    if (NetworkErrorService().returnResponse(response) == 'ok') {
      return response;
    } else {
      // returns error message by status code
      return NetworkErrorService().returnResponse(response);
    }
  }
}
