import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class ThemeDataService {
  final themeData = ThemeData(
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkGrey),
      bodyMedium: TextStyle(color: darkGrey),
      headlineMedium: TextStyle(color: darkGrey),
      headlineSmall: TextStyle(color: darkGrey),
      titleLarge: TextStyle(color: darkGrey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Palette.red),
        fixedSize: MaterialStateProperty.all(
          const Size(295, 50),
        ),
      ),
    ),
    primarySwatch: Colors.red,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF292E4E),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Palette.red,
    ),
  );
}

class Palette {
  static const MaterialColor red = MaterialColor(
    0xFFF96060,
    <int, Color>{
      50: Color(0xffce5641), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );
}
