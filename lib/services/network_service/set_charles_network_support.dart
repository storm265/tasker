import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http_proxy/http_proxy.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> setCharlesSupportNetwork() async {
  if (kReleaseMode) {
    final info = NetworkInfo();
    var locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.location.isRestricted) {
      openAppSettings();
    }

    if (await Permission.location.isGranted) {
      log('gra ${await Permission.location.isGranted}');
      var wifiName = await info.getWifiName();
      log('wifiName $wifiName');

      switch (wifiName) {
        case 'COGNITEQ':
          HttpProxy httpProxy = await HttpProxy.createHttpProxy();
          httpProxy.host = "10.101.4.108";
          httpProxy.port = "8888";
          HttpOverrides.global = httpProxy;
          break;
        case 'Nastya':
          HttpProxy httpProxy = await HttpProxy.createHttpProxy();
          httpProxy.host = "192.168.100.3";
          httpProxy.port = "8888";
          HttpOverrides.global = httpProxy;
          break;
        default:
      }
    }
  }
}
