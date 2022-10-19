import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

final desciptionTextWidget = Padding(
  padding: const EdgeInsets.only(
    left: 2,
    bottom: 10,
  ),
  child: Align(
    alignment: Alignment.topLeft,
    child: Text(
      LocaleKeys.description.tr(),
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
);
