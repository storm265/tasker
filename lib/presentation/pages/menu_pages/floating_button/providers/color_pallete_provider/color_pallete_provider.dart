import 'package:flutter/material.dart';

int _defaultColorIndex = 99;

class ColorPalleteProvider extends ChangeNotifier {

  final selectedIndex = ValueNotifier<int>(_defaultColorIndex);

  bool get isNotPickerColor => selectedIndex.value == 99;
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedIndex.notifyListeners();
  }
}
