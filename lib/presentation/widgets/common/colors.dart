import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

enum CategoryColor {
  blue,
  red,
  green,
  black,
  yellow,
  purple,
}

Color getAppColor({required CategoryColor color}) {
  switch (color) {
    case CategoryColor.blue:
      return colors[0];
    case CategoryColor.red:
      return colors[1];
    case CategoryColor.green:
      return colors[2];
    case CategoryColor.black:
      return colors[3];
    case CategoryColor.yellow:
      return colors[4];
    case CategoryColor.purple:
      return colors[5];
    default:
      return Palette.red;
  }
}

const Color darkGrey = Color(0xFF313131);

final List<Color> colors = [
  const Color(0xff6074F9),
  const Color(0xffE42B6A),
  const Color(0xff5ABB56),
  const Color(0xff3D3A62),
  const Color(0xffF4CA8F),
  const Color(0xFFBC79C3),
];
