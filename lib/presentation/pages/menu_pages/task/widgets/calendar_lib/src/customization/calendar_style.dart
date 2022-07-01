// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';

/// Class containing styling and configuration for `TableCalendar`'s content.
class CalendarStyle {
  /// Maximum amount of single event marker dots to be displayed.
  final int markersMaxCount;

  /// Determines if single event marker dots should be aligned automatically with `markersAnchor`.
  /// If `false`, `markersOffset` will be used instead.
  final bool markersAutoAligned;

  /// The size of single event marker dot.
  ///
  /// By default `markerSizeScale` is used. To use `markerSize` instead, simply provide a non-null value.
  final double? markerSize;

  /// Proportion of single event marker dot size in relation to day cell size.
  ///
  /// Includes `cellMargin` for calculations.
  final double markerSizeScale;

  /// General `Alignment` for event markers.
  /// Will have no effect on markers if `markersAutoAligned` or `markersOffset` is used.
  final AlignmentGeometry markersAlignment;

  /// Decoration of single event markers. Affects each marker dot.
  final Decoration markerDecoration;

  /// Margin of single event markers. Affects each marker dot.
  final EdgeInsets markerMargin;

  /// Alignment of each individual day cell.
  final AlignmentGeometry cellAlignment;

  /// Proportion of range selection highlight size in relation to day cell size.
  ///
  /// Includes `cellMargin` for calculations.
  final double rangeHighlightScale;

  /// Color of range selection highlight.
  final Color rangeHighlightColor;

  /// Determines if day cells that do not match the currently focused month should be visible.
  ///
  /// Affects only `CalendarFormat.month`.
  final bool outsideDaysVisible;

  /// TextStyle for day cells that are currently marked as selected by `selectedDayPredicate`.
  final TextStyle selectedTextStyle;

  /// Decoration for day cells that are currently marked as selected by `selectedDayPredicate`.
  // final Decoration selectedDecoration;

  /// TextStyle for day cells, of which the `day.month` is different than `focusedDay.month`.
  /// This will affect day cells that do not match the currently focused month.
  final TextStyle outsideTextStyle;

  /// Decoration for day cells, of which the `day.month` is different than `focusedDay.month`.
  /// This will affect day cells that do not match the currently focused month.
  final Decoration outsideDecoration;

  /// TextStyle for day cells that have been disabled.
  ///
  /// This refers to dates disabled by returning false in `enabledDayPredicate`,
  /// as well as dates that are outside of the bounds set up by `firstDay` and `lastDay`.
  final TextStyle disabledTextStyle;

  /// Decoration for day cells that have been disabled.
  ///
  /// This refers to dates disabled by returning false in `enabledDayPredicate`,
  /// as well as dates that are outside of the bounds set up by `firstDay` and `lastDay`.
  final Decoration disabledDecoration;

  /// TextStyle for day cells that do not match any other styles.
  final TextStyle defaultTextStyle;

  /// Decoration for day cells that do not match any other styles.
  final Decoration defaultDecoration;

  /// Decoration for each interior row of day cells.
  final Decoration rowDecoration;

  /// Border for the internal `Table` widget.
  final TableBorder tableBorder;

  /// Creates a `CalendarStyle` used by `TableCalendar` widget.
  const CalendarStyle({
    this.outsideDaysVisible = true,
    this.markersAutoAligned = true,
    this.markerSize,
    this.markerSizeScale = 0.2,
    this.rangeHighlightScale = 1.0,
    this.markerMargin = const EdgeInsets.symmetric(horizontal: 0.3),
    this.markersAlignment = Alignment.bottomCenter,
    this.markersMaxCount = 4,
    this.cellAlignment = Alignment.center,
    this.rangeHighlightColor = const Color(0xFFBBDDFF),
    this.markerDecoration = const BoxDecoration(
      color: Color(0xFF263238),
      shape: BoxShape.circle,
    ),
    this.selectedTextStyle = const TextStyle(
      color: Color(0xFFF96060),
      fontSize: 25.0,
    ),
    // this.selectedDecoration = const BoxDecoration(
    //   color: Color(0xFFF96060),
    //   shape: BoxShape.circle,
    // ),
    this.outsideTextStyle = const TextStyle(color: Color(0xFFAEAEAE)),
    this.outsideDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.disabledTextStyle = const TextStyle(color: Color(0xFFBFBFBF)),
    this.disabledDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.defaultTextStyle = const TextStyle(),
    this.defaultDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.rowDecoration = const BoxDecoration(),
    this.tableBorder = const TableBorder(),
  });
}
