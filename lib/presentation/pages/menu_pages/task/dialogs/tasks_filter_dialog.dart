import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

void showTasksFilterDialog(BuildContext context) async {
  final List<String> items = [
    LocaleKeys.incomplete_tasks.tr(),
    LocaleKeys.completed_tasks.tr(),
    LocaleKeys.all_tasks.tr(),
  ];
  int selectedIndex = 99;
  await showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 45,
            right: 12,
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            alignment: Alignment.topRight,
            content: SizedBox(
              width: 230,
              height: 130,
              child: StatefulBuilder(
                builder: (context, setState) => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: ((_, index) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() => selectedIndex = index);
                        await Future.delayed(const Duration(milliseconds: 500))
                            .then((_) => Navigator.pop(context));
                      },
                      child: Row(
                        children: [
                          PopupMenuItem(
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
                          const SizedBox(width: 20),
                          Icon(
                            Icons.done,
                            color: selectedIndex == index
                                ? Colors.green
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      });
}
