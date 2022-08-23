import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/image_widget.dart';

class UserDataWidget extends StatelessWidget {
  final String imageUrl;
  final Map<String, String> imageHeader;
  final String email;
  final String username;

  const UserDataWidget({
    Key? key,
    required this.imageHeader,
    required this.imageUrl,
    required this.email,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 35),
      leading: imageUrl.isEmpty ? const SizedBox() : CachedAvatarWidget(
        imageHeader: imageHeader,
        imageUrl: imageUrl,
      ),
      title: Text(
        username,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w200,
        ),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
