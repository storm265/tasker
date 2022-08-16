import 'package:todo2/database/database_scheme/auth_scheme.dart';

class AuthModel {
  String userId;
  String id;
  String accessToken;
  String refreshToken;
  int expiresIn;

  AuthModel({
    this.id = '',
    this.userId = '',
    this.accessToken = '',
    this.refreshToken = '',
    this.expiresIn = 0,
  });

  factory AuthModel.fromJson({
    required Map<String, dynamic> json,
    bool isSignUp = false,
  }) {
    return AuthModel(
      id: json[AuthScheme.id] ?? 'null',
      userId: json[AuthScheme.userId] ?? 'null',
      accessToken: isSignUp
          ? json[AuthScheme.userSession][AuthScheme.accessToken]
          : json[AuthScheme.accessToken] ?? 'null',
      refreshToken: isSignUp
          ? json[AuthScheme.userSession][AuthScheme.refreshToken]
          : json[AuthScheme.refreshToken] ?? 'null',
      expiresIn: json[AuthScheme.expiresIn] ?? 0,
    );
  }
}
