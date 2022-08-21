import 'package:flutter/material.dart';

class ColorPalleteController extends ChangeNotifier {
  final selectedIndex = ValueNotifier<int>(0);

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedIndex.notifyListeners();
  }

  void disposeIndex() {
    selectedIndex.dispose();
  }
}
