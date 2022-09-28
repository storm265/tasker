import 'package:todo2/database/database_scheme/user_data_scheme..dart';

class UserProfileModel {
  final String id;
  final String username;
  final String email;
  final String avatarUrl;
  final DateTime createdAt;

  UserProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json[UserDataScheme.id],
        avatarUrl: json[UserDataScheme.avatarUrl],
        email: json[UserDataScheme.email],
        username: json[UserDataScheme.username],
        createdAt: DateTime.parse(json[UserDataScheme.createdAt]),
      );
}
