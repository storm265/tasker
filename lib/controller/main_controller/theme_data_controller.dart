import 'package:flutter/material.dart';

class ThemeDataController {
  final themeData = ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.red,
      bottomAppBarColor: Colors.red,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF292E4E),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey));
}
