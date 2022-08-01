import 'package:dio/dio.dart';

class NetworkErrorService {
  String returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return 'ok';
      case 201:
        return 'ok';
      case 400:
        return response.data.toString();
      case 401:
        return response.data.toString();
      case 403:
        return response.data.toString();
      case 500:
      default:
        return 'Communication server error: ${response.statusCode}';
    }
  }
}
