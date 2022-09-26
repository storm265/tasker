import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

final todayTab = Tab(
  child: Text(
    '     ${LocaleKeys.today.tr()}     ',
    style: const TextStyle(
      fontSize: 18,
    ),
  ),
);
final monthTab = Tab(
  child: Text(
    '     ${LocaleKeys.month.tr()}     ',
    style: const TextStyle(
      fontSize: 18,
    ),
  ),
);
