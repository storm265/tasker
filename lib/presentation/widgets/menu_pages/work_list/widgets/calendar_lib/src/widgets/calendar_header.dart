// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../shared/utils.dart' show CalendarFormat;
import 'opener_button.dart';

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;

  final ValueChanged<CalendarFormat> onFormatButtonTap;

  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.onFormatButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            DateFormat.yMMMM(locale).format(focusedMonth),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        IconOpener(onTap: onFormatButtonTap),
      ],
    );
  }
}
