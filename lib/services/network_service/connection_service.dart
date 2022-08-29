import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  
  ConnectivityResult checkConnection() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      connectionStatus = result;
    });

    return connectionStatus;
  }
}
