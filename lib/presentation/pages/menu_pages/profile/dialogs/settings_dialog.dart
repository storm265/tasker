import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/storage/avatar_storage_data_source.dart';
import 'package:todo2/database/repository/storage/avatar_storage_repository.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

Future<void> showSettingsDialog({
  required BuildContext context,
  required ProfileController profileController,
}) async {
  final imageController = ImageController(
    avatarRepository: AvatarStorageReposiroryImpl(
      avatarDataSource: AvatarStorageDataSourceImpl(),
    ),
  );
  final List<String> items = ['Update avatar', 'Sign out'];
  final List<IconData> iconDataItems = [Icons.image, Icons.logout];

  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: 140,
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
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((_, index) {
              return GestureDetector(
                onTap: () async {
                  switch (index) {
                    case 0:
                      await imageController.uploadAvatar(context: context);
                      break;
                    case 1:
                      await profileController.signOut(context: context);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: ListTile(
                      trailing: Icon(
                        iconDataItems[index],
                        color: Palette.red,
                      ),
                      title: Text(
                        items[index],
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
