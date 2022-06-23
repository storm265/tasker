import 'package:todo2/database/database_scheme/user_profile_scheme.dart';

class UserProfileModel {
  String username;
  String avatarUrl;
  String uuid;
  String createdAt;

  UserProfileModel({
    required this.username,
    required this.avatarUrl,
    required this.createdAt,
    required this.uuid,
  });
  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        username: json[UserProfileScheme.username],
        avatarUrl: json[UserProfileScheme.avatarUrl],
        createdAt: json[UserProfileScheme.createdAt],
        uuid: json[UserProfileScheme.uuid],
      );
}
