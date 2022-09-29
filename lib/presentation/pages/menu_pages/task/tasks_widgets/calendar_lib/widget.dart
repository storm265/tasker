import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/presentation/pages/auth/splash_page.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'controller.dart';
import 'datetime_util.dart';
part 'date_box.dart';
part 'month_view.dart';
part 'month_view_bean.dart';
part 'week_days.dart';
part 'week_view.dart';

/// Advanced Calendar widget.
class AdvancedCalendar extends StatefulWidget {
  const AdvancedCalendar({
    Key? key,
    this.controller,
    this.taskController,
    this.startWeekDay = 1,
    this.events,
    this.weekLineHeight = 32.0,
    this.preloadMonthViewAmount = 13,
    this.preloadWeekViewAmount = 21,
    this.weeksInMonthViewAmount = 6,
    this.todayStyle,
    this.dateStyle,
    this.onHorizontalDrag,
    this.innerDot = false,
    this.isMonth = false,
    this.useShadow = true,
    this.canExtend = true,
  }) : super(key: key);

  final AddTaskController? taskController;

  final bool canExtend;

  final bool isMonth;

  final bool useShadow;

  /// Calendar selection date controller.
  final AdvancedCalendarController? controller;

  /// Executes on horizontal calendar swipe. Allows to load additional dates.
  final Function(DateTime)? onHorizontalDrag;

  /// Height of week line.
  final double weekLineHeight;

  /// Amount of months in month view to preload.
  final int preloadMonthViewAmount;

  /// Amount of weeks in week view to preload.
  final int preloadWeekViewAmount;

  /// Weeks lines amount in month view.
  final int weeksInMonthViewAmount;

  /// List of points for the week and month
  final List<DateTime>? events;

  /// The first day of the week starts[0-6]
  final int? startWeekDay;

  /// Style of date
  final TextStyle? dateStyle;

  /// Style of Today button
  final TextStyle? todayStyle;

  /// Show DateBox event in container.
  final bool innerDot;

  @override
  State<AdvancedCalendar> createState() => _AdvancedCalendarState();
}

class _AdvancedCalendarState extends State<AdvancedCalendar>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<int> _monthViewCurrentPage;
  late AnimationController _animationController;
  late AdvancedCalendarController _controller;
  late double _animationValue;
  late List<ViewRange> _monthRangeList;
  late List<List<DateTime>> _weekRangeList;

  PageController? _monthPageController;
  PageController? _weekPageController;

  DateTime? _todayDate;
  List<String>? _weekNames;
  late bool isMonthMode;

  @override
  void initState() {
    super.initState();

    isMonthMode = widget.isMonth;

    final monthPageIndex = widget.preloadMonthViewAmount ~/ 2;

    _monthViewCurrentPage = ValueNotifier(monthPageIndex);

    _monthPageController = PageController(
      initialPage: monthPageIndex,
    );

    final weekPageIndex = widget.preloadWeekViewAmount ~/ 2;

    _weekPageController = PageController(
      initialPage: weekPageIndex,
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0,
    );
    _animationValue = _animationController.value;

    if (isMonthMode) {
      _animationController.forward();
      _animationValue = 1.0;
    }
    _controller = widget.controller ?? AdvancedCalendarController.today();
    _todayDate = _controller.value;

    _monthRangeList = List.generate(
      widget.preloadMonthViewAmount,
      (index) => ViewRange.generateDates(
        _todayDate!,
        _todayDate!.month + (index - _monthPageController!.initialPage),
        widget.weeksInMonthViewAmount,
        startWeekDay: widget.startWeekDay,
      ),
    );

    _weekRangeList = _controller.value.generateWeeks(
      widget.preloadWeekViewAmount,
      startWeekDay: widget.startWeekDay,
    );
    _controller.addListener(() {
      _weekRangeList = _controller.value.generateWeeks(
        widget.preloadWeekViewAmount,
        startWeekDay: widget.startWeekDay,
      );
      _weekPageController!.jumpToPage(widget.preloadWeekViewAmount ~/ 2);
    });
    if (widget.startWeekDay != null && widget.startWeekDay! < 7) {
      final time = _controller.value.subtract(
        Duration(days: _controller.value.weekday - widget.startWeekDay!),
      );
      final list = List<DateTime>.generate(
        8,
        (index) => time.add(Duration(days: index * 1)),
      ).toList();
      _weekNames = locale == 'ru'
          ? List<String>.generate(7, (index) {
              return DateFormat(
                "EEE",
                locale,
              ).format(list[index]).toUpperCase();
            })
          : List<String>.generate(7, (index) {
              return DateFormat(
                "EEEE",
                locale,
              ).format(list[index]).split('').first.toUpperCase();
            });
    }
  }

/*
for ru

List<String>.generate(7, (index) {
        return DateFormat(
          "EEE",
          locale,
        ).format(list[index]).toUpperCase();
      });


for eng

List<String>.generate(7, (index) {
              return DateFormat(
                "EEEE",
                locale,
              ).format(list[index]).split('').first.toUpperCase();
            });
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 17),
      decoration: widget.useShadow
          ? const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 10,
                color: Color(0xFFE3E3E3),
              )
            ])
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ValueListenableBuilder<int>(
              valueListenable: _monthViewCurrentPage,
              builder: (_, value, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat(
                        null,
                        locale,
                      )
                          .add_yMMMM()
                          .format(_monthRangeList[value].firstDay)
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    widget.canExtend
                        ? Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: InkWell(
                              child: Icon(
                                isMonthMode
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.black,
                                size: 27,
                              ),
                              onTap: () async {
                                setState(() {
                                  isMonthMode = !isMonthMode;
                                  widget.taskController
                                      ?.changeTuneIconStatus(!isMonthMode);
                                });

                                if (isMonthMode) {
                                  await _animationController.forward();
                                  _animationValue = 1.0;
                                } else {
                                  await _animationController.reverse();
                                  _animationValue = 0.0;
                                }
                              },
                            ),
                          )
                        : const SizedBox()
                  ],
                );
              },
            ),
          ),
          WeekDays(
            weekNames: _weekNames != null
                ? _weekNames!
                : const <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'],
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              final height = Tween<double>(
                begin: widget.weekLineHeight,
                end: widget.weekLineHeight * widget.weeksInMonthViewAmount,
              ).transform(_animationController.value);
              return SizedBox(
                height: isMonthMode ? 170 : height,
                child: ValueListenableBuilder<DateTime>(
                  valueListenable: _controller,
                  builder: (_, selectedDate, __) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          ignoring: _animationController.value == 0.0,
                          child: Opacity(
                            opacity: Tween<double>(
                              begin: 0.0,
                              end: 1.0,
                            ).evaluate(_animationController),
                            child: PageView.builder(
                              onPageChanged: (pageIndex) {
                                if (widget.onHorizontalDrag != null) {
                                  widget.onHorizontalDrag!(
                                    _monthRangeList[pageIndex].firstDay,
                                  );
                                }
                                _monthViewCurrentPage.value = pageIndex;
                              },
                              controller: _monthPageController,
                              physics: _animationController.value == 1.0
                                  ? const AlwaysScrollableScrollPhysics()
                                  : const NeverScrollableScrollPhysics(),
                              itemCount: _monthRangeList.length,
                              itemBuilder: (_, pageIndex) {
                                return MonthView(
                                  innerDot: widget.innerDot,
                                  monthView: _monthRangeList[pageIndex],
                                  todayDate: _todayDate,
                                  selectedDate: selectedDate,
                                  weekLineHeight: widget.weekLineHeight,
                                  weeksAmount: widget.weeksInMonthViewAmount,
                                  onChanged: _handleDateChanged,
                                  events: widget.events,
                                );
                              },
                            ),
                          ),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _monthViewCurrentPage,
                          builder: (_, pageIndex, __) {
                            final index = selectedDate.findWeekIndex(
                              _monthRangeList[_monthViewCurrentPage.value]
                                  .dates,
                            );
                            final offset = index /
                                    (widget.weeksInMonthViewAmount - 1) *
                                    2 -
                                1.0;
                            return Align(
                              alignment: Alignment(0.0, offset),
                              child: IgnorePointer(
                                ignoring: _animationController.value == 1.0,
                                child: Opacity(
                                  opacity: Tween<double>(
                                    begin: 1.0,
                                    end: 0.0,
                                  ).evaluate(_animationController),
                                  child: SizedBox(
                                    height: widget.weekLineHeight,
                                    child: PageView.builder(
                                      onPageChanged: (indexPage) {
                                        final pageIndex =
                                            _monthRangeList.indexWhere(
                                          (index) =>
                                              index.firstDay.month ==
                                              _weekRangeList[indexPage]
                                                  .first
                                                  .month,
                                        );

                                        if (widget.onHorizontalDrag != null) {
                                          widget.onHorizontalDrag!(
                                            _monthRangeList[pageIndex].firstDay,
                                          );
                                        }
                                        _monthViewCurrentPage.value = pageIndex;
                                      },
                                      controller: _weekPageController,
                                      itemCount: _weekRangeList.length,
                                      physics: closeMonthScroll(),
                                      itemBuilder: (context, index) {
                                        return WeekView(
                                          innerDot: widget.innerDot,
                                          dates: _weekRangeList[index],
                                          selectedDate: selectedDate,
                                          lineHeight: widget.weekLineHeight,
                                          onChanged: _handleWeekDateChanged,
                                          events: widget.events,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleWeekDateChanged(DateTime date) {
    _handleDateChanged(date);

    _monthViewCurrentPage.value = _monthRangeList
        .lastIndexWhere((monthRange) => monthRange.dates.contains(date));
  }

  void _handleDateChanged(DateTime date) {
    _controller.value = date;
  }

  ScrollPhysics closeMonthScroll() {
    if ((_monthViewCurrentPage.value ==
            (widget.preloadMonthViewAmount ~/ 2) + 3 ||
        _monthViewCurrentPage.value ==
            (widget.preloadMonthViewAmount ~/ 2) - 3)) {
      return const NeverScrollableScrollPhysics();
    } else {
      return const AlwaysScrollableScrollPhysics();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _monthPageController!.dispose();
    _monthViewCurrentPage.dispose();

    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }
}
