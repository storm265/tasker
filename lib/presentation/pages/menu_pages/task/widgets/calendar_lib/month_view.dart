part of 'widget.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    Key? key,
    required this.monthView,
    required this.todayDate,
    required this.selectedDate,
    required this.weekLineHeight,
    required this.weeksAmount,
    required this.innerDot,
    this.onChanged,
    this.events,
  }) : super(key: key);

  final ViewRange monthView;
  final DateTime? todayDate;
  final DateTime selectedDate;
  final double weekLineHeight;
  final int weeksAmount;
  final ValueChanged<DateTime>? onChanged;
  final List<DateTime>? events;
  final bool innerDot;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        // column len
        5,
        (weekIndex) {
          final weekStart = weekIndex * 7;

          return WeekView(
            innerDot: innerDot,
            dates: monthView.dates.sublist(weekStart, weekStart + 7),
            selectedDate: selectedDate,
            highlightMonth: monthView.firstDay.month,
            lineHeight: weekLineHeight,
            onChanged: onChanged,
            events: events,
          );
        },
        growable: false,
      ),
    );
  }
}
