// import 'dart:developer';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:todo2/services/navigation_service/navigation_service.dart';

// class NetworkService {
//   void checkConnection(BuildContext context, VoidCallback callback) {
//     Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) async {
//       log(result.toString());
//       if (result == ConnectivityResult.none) {
//         log('Should push!!!');
//         await NavigationService.navigateTo(context, Pages.noConnection);
//       } else {
//       //  callback();
      
//       }
//     });
//   }
// }
