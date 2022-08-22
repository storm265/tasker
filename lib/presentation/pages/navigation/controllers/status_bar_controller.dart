import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class StatusBarController extends ChangeNotifier {
  final isRedStatusBar = ValueNotifier(true);

  void setRedStatusMode(bool newValue) {
    isRedStatusBar.value = newValue;
    isRedStatusBar.notifyListeners();
  }
}

const lightStatusBar = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.black,
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.dark,
);

const redStatusBar = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.black,
  statusBarColor: Palette.red,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);