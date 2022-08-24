import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/cached_avatar_widget.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 40),
        CachedAvatarWidget(
          imageHeader: imageHeader,
          imageUrl: imageUrl,
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Text(
              username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
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
      ],
    );
  }
}
