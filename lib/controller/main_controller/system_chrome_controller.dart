import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemChromeProvider {
  Future<void> setSystemChrome() async {
    await SystemChrome.restoreSystemUIOverlays();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black, systemNavigationBarColor: Colors.black));
  }
}
