// ignore_for_file: non_constant_identifier_names

import 'package:todo2/database/database_scheme/user_profile_scheme.dart';

class UserProfileModel {
  String username, avatar_url, created_at, uid;
  UserProfileModel({
    required this.username,
    required this.avatar_url,
    required this.created_at,
    required this.uid,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        username: json[UserProfileScheme.username],
        avatar_url: json[UserProfileScheme.avatarUrl],
        created_at: json[UserProfileScheme.createdAt],
        uid: json[UserProfileScheme.uid],
      );
}
