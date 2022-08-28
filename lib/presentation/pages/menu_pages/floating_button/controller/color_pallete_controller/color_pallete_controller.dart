import 'package:flutter/material.dart';

int defaultColorIndex = 99;

class ColorPalleteController extends ChangeNotifier {
  String isNotPicked = 'Please, pick color!';
  final selectedIndex = ValueNotifier<int>(defaultColorIndex);

  bool get isNotPickerColor => selectedIndex.value == 99;
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedIndex.notifyListeners();
  }

  void disposeValues() {
    selectedIndex.dispose();
  }
}
