import 'package:dio/dio.dart';

class NetworkErrorService {
  static bool isSuccessful(Response response) {
    int statusCode = response.statusCode ?? 0;
    if (statusCode.toString().startsWith('2')) {
      return true;
    } else {
      return false;
    }
  }
}
