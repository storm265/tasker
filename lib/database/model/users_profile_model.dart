import 'package:todo2/database/database_scheme/user_data_scheme..dart';

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
        id: json[UserDataScheme.id],
        username: json[UserDataScheme.username],
        avatarUrl: json[UserDataScheme.avatarUrl],
        createdAt: json[UserDataScheme.createdAt],
      );
}
