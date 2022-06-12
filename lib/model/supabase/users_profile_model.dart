// ignore_for_file: non_constant_identifier_names

import 'package:todo2/database/database_scheme/user_profile_scheme.dart';

class UsersProfile {
  String username, avatar_url, created_at, uid;
  UsersProfile({
    required this.username,
    required this.avatar_url,
    required this.created_at,
    required this.uid,
  });

  factory UsersProfile.fromJson(Map<String, dynamic> json) => UsersProfile(
        username: json[UserProfileScheme.username] ?? 'empty',
        avatar_url: json[UserProfileScheme.avatarUrl] ?? 'empty',
        created_at: json[UserProfileScheme.createdAt] ?? 'empty',
        uid: json[UserProfileScheme.uid] ?? 'empty',
      );
}
