import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

void showDetailedOptions(BuildContext context) async {
  final List<String> items = [
    LocaleKeys.add_member.tr(),
    LocaleKeys.edit_task.tr(),
    LocaleKeys.delete_task.tr(),
  ];
  await showDialog(
    barrierColor: Colors.black26,
    context: context,
    builder: (_) => Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 100,
          right: 40,
          top: 75,
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((_, index) {
              return GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: PopupMenuItem(
                  enabled: false,
                  height: 40,
                  value: index + 1,
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ),
  );
}
