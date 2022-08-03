import 'package:dio/dio.dart';


class NetworkErrorService implements Exception {
  bool isError({required Response response}) {
    final int statusCode = response.statusCode ?? 0;

    if (statusCode.isBetween(100, 103)) {
      return true;
    } else if (statusCode.isBetween(200, 226)) {
      return false;
    } else if (statusCode > 226) {
      return true;
    }
    return false;
  }
}

extension Range on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}
