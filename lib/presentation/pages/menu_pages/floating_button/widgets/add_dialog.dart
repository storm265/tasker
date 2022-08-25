import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';

Future<void> showAddDialog({
  required BuildContext context,
  required NavigationController navigationController,
}) async {
  final List<String> items = ['Add Task', 'Add Quick Note', 'Add Check List'];
  await showDialog(
    context: context,
    builder: (_) {
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
                      navigationController.pageController.jumpToPage(4);
                      break;
                    case 1:
                      Navigator.pop(context);
                      navigationController.pageController.jumpToPage(5);
                      break;
                    case 2:
                      Navigator.pop(context);
                      navigationController.pageController.jumpToPage(6);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  child: Center(
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
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
