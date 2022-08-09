import 'package:dio/dio.dart';
import 'package:todo2/services/extensions/num_range/num_randge.dart';

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
