import 'package:flutter/material.dart';

enum CategoryColor { blue, red, green, black, yellow }

final List<Color> colors = [
  const Color(0xff6074F9),
  const Color(0xffE42B6A),
  const Color(0xff5ABB56),
  const Color(0xff3D3A62),
  const Color(0xffF4CA8F)
];

class ProjectColor {
  static Color getColor(CategoryColor color) {
    switch (color) {
      case CategoryColor.blue:
        return const Color(0xff6074F9);
      case CategoryColor.red:
        return const Color(0xffE42B6A);
      case CategoryColor.green:
        return const Color(0xff5ABB56);
      case CategoryColor.black:
        return const Color(0xff3D3A62);
      case CategoryColor.yellow:
        return const Color(0xffF4CA8F);
    }
  }
}
