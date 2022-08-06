import 'package:todo2/database/database_scheme/auth_scheme.dart';

class AuthModel {
  String userId;
  String accessToken;
  String refreshToken;
  int expiresIn;

  AuthModel({
    this.userId = '',
    this.accessToken = '',
    this.refreshToken = '',
    this.expiresIn = 0,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json[AuthScheme.userId] ?? 'null',
      accessToken: json[AuthScheme.accessToken] ?? 'null',
      refreshToken: json[AuthScheme.refreshToken] ?? 'null',
      expiresIn: json[AuthScheme.expiresIn] ?? 0,
    );
  }
}
