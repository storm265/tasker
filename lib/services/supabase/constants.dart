import 'package:dio/dio.dart';

class NetworkSource {
  static final NetworkSource _instance = NetworkSource._internal();

  factory NetworkSource() {
    return _instance;
  }

  NetworkSource._internal();

  final NetworkConfiguration _supabaseClient = NetworkConfiguration();

  NetworkConfiguration get networkApiClient => _supabaseClient;
}

class NetworkConfiguration {
  final Dio dio = Dio();
  final String serverUrl = 'https://todolist.dev2.cogniteq.com/api/v1';
}
