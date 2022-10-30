import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

int _defaultColorIndex = 99;

class ColorPalleteProvider extends ChangeNotifier {
  String isNotPicked = LocaleKeys.please_pick_color.tr();
  final selectedIndex = ValueNotifier<int>(_defaultColorIndex);

  bool get isNotPickerColor => selectedIndex.value == 99;
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedIndex.notifyListeners();
  }
}
