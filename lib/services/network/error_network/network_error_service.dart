import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/services/message_service/message_service.dart';

class NetworkErrorService {
  Response<dynamic> returnResponse(
      {required Response response, required BuildContext context}) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw MessageService.displaySnackbar(
            context: context, message: 'error 400');
      case 401:
        throw MessageService.displaySnackbar(
            context: context, message: 'error 401');
      case 403:
        throw MessageService.displaySnackbar(
            context: context, message: 'error 403');
      case 500:
        throw MessageService.displaySnackbar(
            context: context, message: 'error 500');
    }
    return response.data;
  }
}
