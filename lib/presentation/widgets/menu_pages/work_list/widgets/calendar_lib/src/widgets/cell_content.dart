// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;

  final bool isSelected;

  final bool isOutside;
  final bool isDisabled;

  final CalendarStyle calendarStyle;

  const CellContent({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.isSelected,
    required this.isOutside,
    required this.isDisabled,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell;

    final text = '${day.day}';
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;

    if (isDisabled) {
      cell = Container(
        margin: margin,
        padding: padding,
        decoration: calendarStyle.disabledDecoration,
        alignment: alignment,
        child: Text(text, style: calendarStyle.disabledTextStyle),
      );
    } else if (isSelected) {
      cell = Container(
        margin: margin,
        padding: padding,
        //   decoration: calendarStyle.selectedDecoration,
        alignment: alignment,
        child: Text(text, style: calendarStyle.selectedTextStyle),
      );
    }

    // is after/before month range
    else if (isOutside) {
      cell = Container(
        margin: margin,
        padding: padding,
        decoration: calendarStyle.outsideDecoration,
        alignment: alignment,
        child: Text(text, style: calendarStyle.outsideTextStyle),
      );
    } else {
      cell = Container(
        margin: margin,
        padding: padding,
        decoration: calendarStyle.defaultDecoration,
        alignment: alignment,
        child: Text(text, style: calendarStyle.defaultTextStyle),
      );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}
