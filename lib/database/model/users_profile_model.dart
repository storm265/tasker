import 'package:todo2/database/database_scheme/user_profile_scheme.dart';

class UserProfileModel {
  String username;
  String avatarUrl;
  String id;
  String createdAt;

  UserProfileModel({
    required this.username,
    required this.avatarUrl,
    required this.createdAt,
    required this.id,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        username: json[UserProfileScheme.username],
        avatarUrl: json[UserProfileScheme.avatarPath],
        createdAt: json[UserProfileScheme.createdAt],
        id: json[UserProfileScheme.id],
      );
}
