import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

class CategoryLengthWidget extends StatelessWidget {
  final int taskLength;
  const CategoryLengthWidget({Key? key, required this.taskLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        //   '$taskLength ${taskLength == 1 ? LocaleKeys.tasks.tr() : 'Tasks'}',
        '$taskLength ${LocaleKeys.tasks.tr()}',
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
