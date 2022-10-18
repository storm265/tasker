import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';

class UserDataWidget extends StatelessWidget {
  final ProfileController profileController;
  const UserDataWidget({
    super.key,
    required this.profileController,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profileController.email,
            style: const TextStyle(
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            profileController.username,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
