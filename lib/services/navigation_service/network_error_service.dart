import 'package:dio/dio.dart';

// TODO: actually, it makes sense to create an extension for Response.dart (dio) to do that assert
class NetworkErrorService {
  static bool isSuccessful(Response response) {
    int statusCode = response.statusCode ?? 0;
    if (statusCode > 199 && statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }
}
