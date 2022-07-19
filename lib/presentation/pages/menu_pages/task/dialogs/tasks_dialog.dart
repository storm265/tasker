import 'package:flutter/material.dart';

void showTasksDialog(BuildContext context) {
  final List<String> items = [
    'Incomplete Tasks',
    'Completed Tasks',
    'All Tasks'
  ];
  final taskDialogController = TaskDialogController();
  showDialog(
      barrierColor: Colors.black38,
      context: context,
      builder: (_) {
        return AlertDialog(
          insetPadding: const EdgeInsets.only(left: 100, bottom: 540),
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            height: 120,
            width: 150,
            child: ListView.builder(
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
                                fontWeight: FontWeight.w300,
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
          ),
        );
      });
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
