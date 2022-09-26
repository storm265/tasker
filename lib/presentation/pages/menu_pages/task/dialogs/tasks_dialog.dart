import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

void showTasksDialog(BuildContext context) {
  final List<String> items = [
    LocaleKeys.incomplete_tasks.tr(),
    LocaleKeys.completed_tasks.tr(),
    LocaleKeys.all_tasks.tr(),
  ];
  final taskDialogController = TaskDialogController();
  showDialog(
    barrierColor: Colors.black26,
    context: context,
    builder: (_) => Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 140,
          right: 12,
          top: 45,
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
                  taskDialogController.changeSelectedIndex(index);
                  await Future.delayed(const Duration(milliseconds: 500))
                      .then((_) => Navigator.pop(context));
                },
                child: ValueListenableBuilder<int?>(
                  valueListenable: taskDialogController.selectedIndex,
                  builder: (context, value, _) {
                    return Row(
                      children: [
                        const SizedBox(width: 10),
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
                        const SizedBox(width: 30),
                        Icon(
                          Icons.done,
                          color: value == index
                              ? Colors.green
                              : Colors.transparent,
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    ),
  );
}

class TaskDialogController extends ChangeNotifier {
  final selectedIndex = ValueNotifier<int?>(null);
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    notifyListeners();
  }

  void disposeIndex() {
    selectedIndex.dispose();
  }
}
/*
ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((_, index) {
              return GestureDetector(
                onTap: () async {
                  taskDialogController.changeSelectedIndex(index);
                  await Future.delayed(const Duration(milliseconds: 500))
                      .then((_) => Navigator.pop(context));
                },
                child: ValueListenableBuilder<int?>(
                  valueListenable: taskDialogController.selectedIndex,
                  builder: (context, value, _) {
                    return Row(
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
                        Icon(
                          Icons.done,
                          color: value == index
                              ? Colors.green
                              : Colors.transparent,
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ),
*/
