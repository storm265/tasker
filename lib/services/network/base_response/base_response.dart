import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/services/network/error_network/network_error_service.dart';

class BaseResponse {
  Response response;
  NetworkErrorService error;
  BuildContext context;

  BaseResponse({
    required this.response,
    required this.error,
    required this.context,
  });

  Response isSuccessful() {
    return error.returnResponse(response: response, context: context);
  }
}
