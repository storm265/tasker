import 'package:dio/dio.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

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
  final Dio dio = Dio()
    ..options.baseUrl = 'https://todolist.dev2.cogniteq.com/api/v1';
  final String storagePath = '=@"/Users/andreikastsiuk/Downloads';
  final String tokenType = 'Bearer';

  final Options authOptions = Options(
    validateStatus: (_) => true,
    headers: {
      'Content-Type': 'application/json',
    },
  );
  final _storageSource = SecureStorageSource().storageApi;
  
  Options getRequestOptions() {
    return Options(
      headers: {
        'Authorization':
            '$tokenType ${_storageSource.getUserData(type: StorageDataType.accessToken)}'
      },
    );
  }
}
