import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class NetworkService {
  void checkConnection(BuildContext context, VoidCallback callback) {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        await NavigationService.navigateTo(context, Pages.noConnection);
      } else {
      //  callback();
      
      }
    });
  }
}
