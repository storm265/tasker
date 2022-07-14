import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
    // TODO fix it;
class NetworkService {
  void checkConnection(BuildContext context, VoidCallback callback) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result.name);
      result == ConnectivityResult.none
          ? NavigationService.navigateTo(context, Pages.noConnection)
          : callback();
    });
  }
}
