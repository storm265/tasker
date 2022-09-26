import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/painting.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

final List<String> labels = [
  LocaleKeys.events.tr(),
  LocaleKeys.to_do_task.tr(),
  LocaleKeys.quick_notes.tr(),
];
final List<Color> statsColors = [
  Palette.red,
  getAppColor(color: CategoryColor.blue),
  const Color(0xFF8560F9),
];
