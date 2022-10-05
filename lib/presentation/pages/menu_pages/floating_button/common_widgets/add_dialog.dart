import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

Future<void> showAddDialog({required BuildContext context}) async {
  final List<String> items = [
    LocaleKeys.add_task.tr(),
    LocaleKeys.add_quick_note.tr(),
    LocaleKeys.add_check_list.tr(),
  ];
  await showDialog(
    context: context,
    builder: (_) {
      final navigationController =
          NavigationInherited.of(context).navigationController;
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: 214,
          width: 268,
          child: ListView.separated(
            separatorBuilder: (_, __) {
              return SizedBox(
                height: 2,
                width: 268,
                child: ColoredBox(
                  color: Colors.grey.withOpacity(0.3),
                ),
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((_, index) {
              return GestureDetector(
                onTap: () async {
                  switch (index) {
                    case 0:
                      Navigator.pop(context);
                      await NavigationService.navigateTo(
                          context, Pages.addTask);

                      break;
                    case 1:
                      Navigator.pop(context);
                      await navigationController.moveToPage(Pages.addNote);
                      break;
                    case 2:
                      Navigator.pop(context);
                      await navigationController.moveToPage(Pages.addCheckList);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  child: Center(
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    },
  );
}
