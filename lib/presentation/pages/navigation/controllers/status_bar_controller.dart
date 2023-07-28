import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/utils/theme_util.dart';

enum StatusBarColors {
  red,
  white,
  blue,
}

class StatusBarController extends ChangeNotifier {
  final statusBarStatus = ValueNotifier<StatusBarColors>(StatusBarColors.red);
  void setStatusModeColor(StatusBarColors newValue) {
    statusBarStatus.value = newValue;
    statusBarStatus.notifyListeners();
  }
}

SystemUiOverlayStyle getStatusBarColor(StatusBarColors status) {
  switch (status) {
    case StatusBarColors.white:
      return lightStatusBar;
    case StatusBarColors.red:
      return redStatusBar;
    case StatusBarColors.blue:
      return blueStatusBar;
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

final blueStatusBar = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.black,
  statusBarColor: getAppColor(color: CategoryColor.blue),
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);
