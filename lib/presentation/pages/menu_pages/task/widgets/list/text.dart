import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ListDayWidget extends StatelessWidget {
  final int index;
  final DateTime date;
  const ListDayWidget({
    Key? key,
    required this.date,
    required this.index,
  }) : super(key: key);
  String getDay(int index) {
    switch (index) {
      case 0:
        return 'Today';
      case 1:
        return 'Tomorrow';
      default:
        return '${date.day + index}';
    }
  }

  @override
  Widget build(BuildContext context) {
    String isToday = getDay(index);
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          '$isToday, ${DateFormat('MMM').format(date)} ${date.day + index}/${date.year}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
