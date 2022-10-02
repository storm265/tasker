import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

final List<String> settingsTextItems = [
  LocaleKeys.update_avatar.tr(),
  LocaleKeys.language.tr(),
  LocaleKeys.sign_out.tr(),
];
const List<IconData> settingsIconsItems = [
  Icons.image,
  Icons.language,
  Icons.logout,
];
