import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/image_widget.dart';

class UserDataWidget extends StatelessWidget {
  final String avatarImage;
  final String email;
  final String nickname;
  
  const UserDataWidget({
    Key? key,
    required this.avatarImage,
    required this.email,
    required this.nickname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      child: SizedBox(
        width: 300,
        height: 70,
        child: ListTile(
          leading: CachedAvatarWidget(image: avatarImage),
          title: Text(
            nickname,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
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
        ),
      ),
    );
  }
}
