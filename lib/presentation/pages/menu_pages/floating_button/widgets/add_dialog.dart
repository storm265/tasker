import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

Future<void> showAddDialog(BuildContext context) async {
  final List<String> items = ['Add Task', 'Add Quick Note', 'Add Check List'];
  await showDialog(
    context: context,
    builder: (_) {
      final _inheritedNavigatorConroller =
          InheritedNavigator.of(context)!.navigationController;
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
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.pop(context);
                      NavigationService.navigateTo(context, Pages.addTask);
                      break;
                    case 1:
                      Navigator.pop(context);
                      _inheritedNavigatorConroller
                          .animateToPage(NavigationPages.addQuickNote);

                      break;
                    case 2:
                      Navigator.pop(context);
                      _inheritedNavigatorConroller
                          .animateToPage(NavigationPages.addCheckList);
                      break;
                    default:
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  child: Center(
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
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
