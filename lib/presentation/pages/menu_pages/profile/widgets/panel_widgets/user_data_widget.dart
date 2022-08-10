import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/image_widget.dart';

class UserDataWidget extends StatelessWidget {
  final String avatarImage;
  final String email;
  final String username;

  const UserDataWidget({
    Key? key,
    required this.avatarImage,
    required this.email,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 35),
      leading: avatarImage != ''
          ? CachedAvatarWidget(image: avatarImage)
          : const SizedBox(),
      title: Text(
        username,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
        ),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
