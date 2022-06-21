import 'package:flutter/services.dart';

class SystemChromeProvider {
  static Future<void> setSystemChrome() async {
    await SystemChrome.restoreSystemUIOverlays();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
