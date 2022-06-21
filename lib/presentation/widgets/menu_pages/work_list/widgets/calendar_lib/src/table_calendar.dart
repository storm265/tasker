// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0


import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'customization/calendar_builders.dart';
import 'customization/calendar_style.dart';
import 'customization/days_of_week_style.dart';

import 'shared/utils.dart';
import 'table_calendar_base.dart';
import 'widgets/calendar_header.dart';
import 'widgets/cell_content.dart';

/// Signature for `onDaySelected` callback. Contains the selected day and focused day.
typedef OnDaySelected = void Function(
    DateTime selectedDay, DateTime focusedDay);

/// Signature for `onRangeSelected` callback.
/// Contains start and end of the selected range, as well as currently focused day.
typedef OnRangeSelected = void Function(
    DateTime? start, DateTime? end, DateTime focusedDay);

/// Modes that range selection can operate in.
enum RangeSelectionMode { disabled, toggledOff, toggledOn, enforced }

/// Highly customizable, feature-packed Flutter calendar with gestures, animations and multiple formats.
class TableCalendar<T> extends StatefulWidget {
  /// Locale to format `TableCalendar` dates with, for example: `'en_US'`.
  ///
  /// If nothing is provided, a default locale will be used.
  final dynamic locale;

  /// The start of the selected day range.
  final DateTime? rangeStartDay;

  /// The end of the selected day range.
  final DateTime? rangeEndDay;

  /// DateTime that determines which days are currently visible and focused.
  final DateTime focusedDay;

  /// The first active day of `TableCalendar`.
  /// Blocks swiping to days before it.
  ///
  /// Days before it will use `disabledStyle` and trigger `onDisabledDayTapped` callback.
  final DateTime firstDay;

  /// The last active day of `TableCalendar`.
  /// Blocks swiping to days after it.
  ///
  /// Days after it will use `disabledStyle` and trigger `onDisabledDayTapped` callback.
  final DateTime lastDay;

  /// DateTime that will be treated as today. Defaults to `DateTime.now()`.
  ///
  /// Overriding this property might be useful for testing.
  final DateTime? currentDay;

  /// List of days treated as weekend days.
  /// Use built-in `DateTime` weekday constants (e.g. `DateTime.monday`) instead of `int` literals (e.g. `1`).
  final List<int> weekendDays;

  /// Specifies `TableCalendar`'s current format.
  final CalendarFormat calendarFormat;

  /// `Map` of `CalendarFormat`s and `String` names associated with them.
  /// Those `CalendarFormat`s will be used by internal logic to manage displayed format.
  ///
  /// To ensure proper vertical swipe behavior, `CalendarFormat`s should be in descending order (i.e. from biggest to smallest).
  ///
  /// For example:
  /// ```dart
  /// availableCalendarFormats: const {
  ///   CalendarFormat.month: 'Month',
  ///   CalendarFormat.week: 'Week',
  /// }
  /// ```
  final Map<CalendarFormat, String> availableCalendarFormats;

  /// Determines the visibility of calendar header.
  final bool headerVisible;

  /// Determines the visibility of the row of days of the week.
  final bool daysOfWeekVisible;

  /// When set to true, tapping on an outside day in `CalendarFormat.month` format
  /// will jump to the calendar page of the tapped month.
  final bool pageJumpingEnabled;

  /// When set to true, updating the `focusedDay` will display a scrolling animation
  /// if the currently visible calendar page is changed.
  final bool pageAnimationEnabled;

  /// When set to true, `CalendarFormat.month` will always display six weeks,
  /// even if the content would fit in less.
  final bool sixWeekMonthsEnforced;

  /// When set to true, `TableCalendar` will fill available height.
  final bool shouldFillViewport;

  /// Used for setting the height of `TableCalendar`'s rows.
  final double rowHeight;

  /// Used for setting the height of `TableCalendar`'s days of week row.
  final double daysOfWeekHeight;

  /// Specifies the duration of size animation that takes place whenever `calendarFormat` is changed.
  final Duration formatAnimationDuration;

  /// Specifies the curve of size animation that takes place whenever `calendarFormat` is changed.
  final Curve formatAnimationCurve;

  /// Specifies the duration of scrolling animation that takes place whenever the visible calendar page is changed.
  final Duration pageAnimationDuration;

  /// Specifies the curve of scrolling animation that takes place whenever the visible calendar page is changed.
  final Curve pageAnimationCurve;

  /// `TableCalendar` will start weeks with provided day.
  ///
  /// Use `StartingDayOfWeek.monday` for Monday - Sunday week format.
  /// Use `StartingDayOfWeek.sunday` for Sunday - Saturday week format.
  final StartingDayOfWeek startingDayOfWeek;

  /// `HitTestBehavior` for every day cell inside `TableCalendar`.
  final HitTestBehavior dayHitTestBehavior;

  /// Specifies swipe gestures available to `TableCalendar`.
  /// If `AvailableGestures.none` is used, the calendar will only be interactive via buttons.
  final AvailableGestures availableGestures;

  /// Configuration for vertical swipe detector.
  final SimpleSwipeConfig simpleSwipeConfig;

  /// Style for days of week displayed between `TableCalendar`'s header and content.
  final DaysOfWeekStyle daysOfWeekStyle;

  /// Style for `TableCalendar`'s content.
  final CalendarStyle calendarStyle;

  /// Set of custom builders for `TableCalendar` to work with.
  /// Use those to fully tailor the UI.
  final CalendarBuilders<T> calendarBuilders;

  /// Current mode of range selection.
  ///
  /// * `RangeSelectionMode.disabled` - range selection is always off.
  /// * `RangeSelectionMode.toggledOff` - range selection is currently off, can be toggled by longpressing a day cell.
  /// * `RangeSelectionMode.toggledOn` - range selection is currently on, can be toggled by longpressing a day cell.
  /// * `RangeSelectionMode.enforced` - range selection is always on.
  final RangeSelectionMode rangeSelectionMode;

  /// Function that assigns a list of events to a specified day.
  final List<T> Function(DateTime day)? eventLoader;

  /// Function deciding whether given day should be enabled or not.
  /// If `false` is returned, this day will be disabled.
  final bool Function(DateTime day)? enabledDayPredicate;

  /// Function deciding whether given day should be marked as selected.
  final bool Function(DateTime day)? selectedDayPredicate;

  /// Function deciding whether given day is treated as a holiday.
  final bool Function(DateTime day)? holidayPredicate;

  /// Called whenever a day range gets selected.
  final OnRangeSelected? onRangeSelected;

  /// Called whenever any day gets tapped.
  final OnDaySelected? onDaySelected;

  /// Called whenever any disabled day gets tapped.
  final void Function(DateTime day)? onDisabledDayTapped;

  /// Called whenever header gets long pressed.
  final void Function(DateTime focusedDay)? onHeaderLongPressed;

  /// Called whenever currently visible calendar page is changed.
  final void Function(DateTime focusedDay)? onPageChanged;

  /// Called whenever `calendarFormat` is changed.
  final void Function(CalendarFormat format)? onFormatChanged;

  /// Called when the calendar is created. Exposes its PageController.
  final void Function(PageController pageController)? onCalendarCreated;
final bool shouldHideButton;
  /// Creates a `TableCalendar` widget.
  TableCalendar({
    Key? key,
    required this.shouldHideButton,
    required DateTime focusedDay,
    required DateTime firstDay,
    required DateTime lastDay,
    DateTime? currentDay,
    this.locale,
    this.rangeStartDay,
    this.rangeEndDay,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.calendarFormat = CalendarFormat.month,
    this.availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.week: 'Week',
    },
    this.headerVisible = true,
    this.daysOfWeekVisible = true,
    this.pageJumpingEnabled = false,
    this.pageAnimationEnabled = true,
    this.sixWeekMonthsEnforced = false,
    this.shouldFillViewport = false,
    this.rowHeight = 52.0,
    this.daysOfWeekHeight = 16.0,
    this.formatAnimationDuration = const Duration(milliseconds: 200),
    this.formatAnimationCurve = Curves.linear,
    this.pageAnimationDuration = const Duration(milliseconds: 300),
    this.pageAnimationCurve = Curves.easeOut,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.dayHitTestBehavior = HitTestBehavior.opaque,
    this.availableGestures = AvailableGestures.all,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.daysOfWeekStyle = const DaysOfWeekStyle(),
    this.calendarStyle = const CalendarStyle(),
    this.calendarBuilders = const CalendarBuilders(),
    this.rangeSelectionMode = RangeSelectionMode.toggledOff,
    this.eventLoader,
    this.enabledDayPredicate,
    this.selectedDayPredicate,
    this.holidayPredicate,
    this.onRangeSelected,
    this.onDaySelected,
    this.onDisabledDayTapped,
    this.onHeaderLongPressed,
    this.onPageChanged,
    this.onFormatChanged,
    this.onCalendarCreated,
  })  : assert(availableCalendarFormats.keys.contains(calendarFormat)),
        assert(availableCalendarFormats.length <= CalendarFormat.values.length),
        assert(weekendDays.isNotEmpty
            ? weekendDays.every(
                (day) => day >= DateTime.monday && day <= DateTime.sunday)
            : true),
        focusedDay = normalizeDate(focusedDay),
        firstDay = normalizeDate(firstDay),
        lastDay = normalizeDate(lastDay),
        currentDay = currentDay ?? DateTime.now(),
        super(key: key);

  @override
  TableCalendarState<T> createState() => TableCalendarState<T>();
}

class TableCalendarState<T> extends State<TableCalendar<T>> {
  late final PageController _pageController;
  late final ValueNotifier<DateTime> _focusedDay;
  late RangeSelectionMode _rangeSelectionMode;
  DateTime? _firstSelectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(widget.focusedDay);
    _rangeSelectionMode = widget.rangeSelectionMode;
  }

  @override
  void didUpdateWidget(TableCalendar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_focusedDay.value != widget.focusedDay) {
      _focusedDay.value = widget.focusedDay;
    }

    if (_rangeSelectionMode != widget.rangeSelectionMode) {
      _rangeSelectionMode = widget.rangeSelectionMode;
    }

    if (widget.rangeStartDay == null && widget.rangeEndDay == null) {
      _firstSelectedDay = null;
    }
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  bool get _isRangeSelectionOn =>
      _rangeSelectionMode == RangeSelectionMode.toggledOn ||
      _rangeSelectionMode == RangeSelectionMode.enforced;

  bool get _shouldBlockOutsideDays =>
      !widget.calendarStyle.outsideDaysVisible &&
      widget.calendarFormat == CalendarFormat.month;



  void _onDayTapped(DateTime day) {

    final isOutside = day.month != _focusedDay.value.month;
    if (isOutside && _shouldBlockOutsideDays) {
      return;
    }

    if (_isDayDisabled(day)) {
      return widget.onDisabledDayTapped?.call(day);
    }

    _updateFocusOnTap(day);

    if (_isRangeSelectionOn && widget.onRangeSelected != null) {
      if (_firstSelectedDay == null) {
        _firstSelectedDay = day;
        widget.onRangeSelected!(_firstSelectedDay, null, _focusedDay.value);
      } else {
        if (day.isAfter(_firstSelectedDay!)) {
          widget.onRangeSelected!(_firstSelectedDay, day, _focusedDay.value);
          _firstSelectedDay = null;
        } else if (day.isBefore(_firstSelectedDay!)) {
          widget.onRangeSelected!(day, _firstSelectedDay, _focusedDay.value);
          _firstSelectedDay = null;
        }
      }
    } else {
      widget.onDaySelected?.call(day, _focusedDay.value);
    }
  }

  void _updateFocusOnTap(DateTime day) {
    if (widget.pageJumpingEnabled) {
      _focusedDay.value = day;
      return;
    }

    if (widget.calendarFormat == CalendarFormat.month) {
      if (_isBeforeMonth(day, _focusedDay.value)) {
        _focusedDay.value = _firstDayOfMonth(_focusedDay.value);
      } else if (_isAfterMonth(day, _focusedDay.value)) {
        _focusedDay.value = _lastDayOfMonth(_focusedDay.value);
      } else {
        _focusedDay.value = day;
      }
    } else {
      _focusedDay.value = day;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.headerVisible)
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return CalendarHeader(
                shouldHideButton: widget.shouldHideButton,
                focusedMonth: value,
                locale: widget.locale,
                onFormatButtonTap: (format) {
                  assert(
                    widget.onFormatChanged != null,
                    'Using `FormatButton` without providing `onFormatChanged` will have no effect.',
                  );

                  widget.onFormatChanged?.call(format);
                },
              );
            },
          ),
        Flexible(
          flex: widget.shouldFillViewport ? 1 : 0,
          child: TableCalendarBase(
            onCalendarCreated: (pageController) {
              _pageController = pageController;
              widget.onCalendarCreated?.call(pageController);
            },
            focusedDay: _focusedDay.value,
            calendarFormat: widget.calendarFormat,
            availableGestures: widget.availableGestures,
            firstDay: widget.firstDay,
            lastDay: widget.lastDay,
            startingDayOfWeek: widget.startingDayOfWeek,
            dowDecoration: widget.daysOfWeekStyle.decoration,
            rowDecoration: widget.calendarStyle.rowDecoration,
            tableBorder: widget.calendarStyle.tableBorder,
            dowVisible: widget.daysOfWeekVisible,
            dowHeight: widget.daysOfWeekHeight,
            rowHeight: widget.rowHeight,
            formatAnimationDuration: widget.formatAnimationDuration,
            formatAnimationCurve: widget.formatAnimationCurve,
            pageAnimationEnabled: widget.pageAnimationEnabled,
            pageAnimationDuration: widget.pageAnimationDuration,
            pageAnimationCurve: widget.pageAnimationCurve,
            availableCalendarFormats: widget.availableCalendarFormats,
            simpleSwipeConfig: widget.simpleSwipeConfig,
            sixWeekMonthsEnforced: widget.sixWeekMonthsEnforced,
          
            onPageChanged: (focusedDay) {
              _focusedDay.value = focusedDay;
              widget.onPageChanged?.call(focusedDay);
            },
            dowBuilder: (BuildContext context, DateTime day) {
              Widget? dowCell =
                  widget.calendarBuilders.dowBuilder?.call(context, day);

              dowCell ??= Center(
                child: ExcludeSemantics(
                  child: Text(
                    DateFormat.E(widget.locale).format(day).substring(0, 1),
                    style: widget.daysOfWeekStyle.weekendStyle,
                  ),
                ),
              );

              return dowCell;
            },
            dayBuilder: (context, day, focusedMonth) {
              return GestureDetector(
                behavior: widget.dayHitTestBehavior,
                onTap: () => _onDayTapped(day),
                child: _buildCell(day, focusedMonth),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCell(DateTime day, DateTime focusedDay) {
    final isOutside = day.month != focusedDay.month;

    if (isOutside && _shouldBlockOutsideDays) {
      return Container();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final children = <Widget>[];

        final isDisabled = _isDayDisabled(day);

        Widget content = CellContent(
          key: ValueKey('CellContent-${day.year}-${day.month}-${day.day}'),
          day: day,
          focusedDay: focusedDay,
          calendarStyle: widget.calendarStyle,
          isSelected: widget.selectedDayPredicate?.call(day) ?? false,
          isOutside: isOutside,
          isDisabled: isDisabled,
          locale: widget.locale,
        );

        children.add(content);

        if (!isDisabled) {
          final events = widget.eventLoader?.call(day) ?? [];
          Widget? markerWidget =
              widget.calendarBuilders.markerBuilder?.call(context, day, events);

          if (markerWidget != null) {
            children.add(markerWidget);
          }
        }

        return Stack(
          alignment: widget.calendarStyle.markersAlignment,
          children: children,
        );
      },
    );
  }

  bool _isDayDisabled(DateTime day) {
    return day.isBefore(widget.firstDay) ||
        day.isAfter(widget.lastDay) ||
        !_isDayAvailable(day);
  }

  bool _isDayAvailable(DateTime day) {
    return widget.enabledDayPredicate == null
        ? true
        : widget.enabledDayPredicate!(day);
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1)
        : DateTime.utc(month.year + 1, 1, 1);
    return date.subtract(const Duration(days: 1));
  }

  bool _isBeforeMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month < month.month;
    } else {
      return day.isBefore(month);
    }
  }

  bool _isAfterMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month > month.month;
    } else {
      return day.isAfter(month);
    }
  }
}
