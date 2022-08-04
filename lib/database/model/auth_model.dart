import 'package:todo2/database/database_scheme/auth_scheme.dart';

class AuthModel {
  String userId;
  String accessToken;
  String refreshToken;
  int expiresIn;

  AuthModel({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json[AuthScheme.userId],
      accessToken: json[AuthScheme.accessToken],
      refreshToken: json[AuthScheme.refreshToken],
      expiresIn: json[AuthScheme.expiresIn],
    );
  }
}
