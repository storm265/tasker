import 'package:flutter/material.dart';

class ColorPalleteProvider extends ChangeNotifier {
  final selectedIndex = ValueNotifier<int>(99);

  bool get isNotPickerColor => selectedIndex.value == 99;
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedIndex.notifyListeners();
  }
}
