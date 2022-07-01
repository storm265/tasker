// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';


/// Class containing styling for `TableCalendar`'s days of week panel.
class DaysOfWeekStyle {

  /// Style for weekdays on the top of calendar.
  final TextStyle weekdayStyle;

  /// Style for weekend days on the top of calendar.
  final TextStyle weekendStyle;

  /// Creates a `DaysOfWeekStyle` used by `TableCalendar` widget.
  const DaysOfWeekStyle({
    this.weekdayStyle = const TextStyle(color:  Color(0xFF4F4F4F)),
    this.weekendStyle = const TextStyle(color:  Color(0xFF6A6A6A)),
  });
}
