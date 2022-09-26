import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/detailed_task.dart';

class ListDayWidget extends StatelessWidget {
  final bool isToday;
  const ListDayWidget({
    Key? key,
    required this.isToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return GestureDetector(
      onTap: () async => await showDialog(
        context: context,
        builder: (_) => const DetailedTaskPage(),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Text(
            isToday
                ? '${LocaleKeys.today.tr()}, ${DateFormat('MMM').format(now)} ${now.day}/${now.year}'
                : '${LocaleKeys.tomorrow.tr()}, ${DateFormat('MMM').format(now)} ${now.day + 1}/${now.year}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
