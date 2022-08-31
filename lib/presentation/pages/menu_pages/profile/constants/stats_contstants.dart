import 'package:flutter/painting.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

const List<String> labels = [
  'Events',
  'To do',
  'Quick Notes',
];
final List<Color> statsColors = [
  Palette.red,
  getAppColor(color: CategoryColor.blue),
 const Color(0xFF8560F9),
];
