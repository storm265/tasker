import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/cached_avatar_widget.dart';

class UserDataWidget extends StatelessWidget {
  final ProfileController profileController;
  final String email;
  final String username;

  const UserDataWidget({
    Key? key,
    required this.profileController,
    required this.email,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 30),
          CachedAvatarWidget(
            profileController: profileController,
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
