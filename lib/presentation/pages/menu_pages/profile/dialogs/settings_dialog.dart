import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';

import 'package:todo2/services/navigation_service/navigation_service.dart';

Future<void> showSettingsDialog(BuildContext context) async {
  final profileController = ProfileController();
  final List<String> items = ['Update avatar', 'Update password', 'Sign out'];
  final List<IconData> iconDataItems = [Icons.image, Icons.add, Icons.logout];

  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: 200,
          width: 270,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
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
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: ((_, index) {
              return GestureDetector(
                onTap: () async {
                  switch (index) {
                    case 0:
                      break;
                    case 1:
                      Navigator.pop(context);
                      await NavigationService.navigateTo(
                        context,
                        Pages.newPassword,
                        arguments: true,
                      );

                      break;
                    case 2:
                      await profileController.signOut(context);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  child: Center(
                    child: ListTile(
                      trailing: Icon(
                        iconDataItems[index],
                        color: Colors.black,
                      ),
                      title: Text(
                        items[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
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
