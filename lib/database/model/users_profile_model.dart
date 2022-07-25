import 'package:todo2/database/database_scheme/user_profile_scheme.dart';

class UserProfileModel {
  String id;
  String username;
  String avatarUrl;
  String createdAt;

  UserProfileModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json[UserProfileScheme.id],
        username: json[UserProfileScheme.username],
        avatarUrl: json[UserProfileScheme.avatarPath],
        createdAt: json[UserProfileScheme.createdAt],
      );
}
