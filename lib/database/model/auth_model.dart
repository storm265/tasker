import 'package:todo2/database/database_scheme/auth_scheme.dart';

class AuthModel {
  String id;
  String accessToken;
  String refreshToken;
  int expiresIn;

  AuthModel({
    this.id = '',
    this.accessToken = '',
    this.refreshToken = '',
    this.expiresIn = 0,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json[AuthScheme.id] ?? 'null',
      accessToken: json[AuthScheme.accessToken] ?? 'null',
      refreshToken: json[AuthScheme.refreshToken] ?? 'null',
      expiresIn: json[AuthScheme.expiresIn] ?? 0,
    );
  }
}
