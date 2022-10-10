import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/controller/file_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/profile_dialog_items.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

Future<void> showSettingsDialog({
  required BuildContext context,
  required FileProvider imageController,
  required ProfileController profileController,
  required VoidCallback callback,
}) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: 210,
          width: 250,
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
            itemCount: settingsTextItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((_, i) {
              return GestureDetector(
                onTap: () async {
                  switch (i) {
                    case 0:
                      await imageController.updateAvatar(
                        callback: () => callback(),
                        context: context,
                        profileController: profileController,
                      );
                      break;
                    case 1:
                      await profileController.changeLocalization(context).then(
                            (_) => Navigator.pop(context),
                          );
                      break;
                    case 2:
                      await profileController.signOut(context: context);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: ListTile(
                      trailing: i == 1
                          ? SizedBox(
                              width: 50,
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    context.locale.toString().substring(0, 2),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Icon(
                                    settingsIconsItems[i],
                                    color: Palette.red,
                                  ),
                                ],
                              ),
                            )
                          : Icon(
                              settingsIconsItems[i],
                              color: Palette.red,
                            ),
                      title: Text(
                        settingsTextItems[i],
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
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
