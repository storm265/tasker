import 'package:todo2/database/database_scheme/auth_scheme.dart';

class AuthModel {
  String accessToken;
  String refreshToken;
  int expiresIn;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json[AuthScheme.accessToken],
      refreshToken: json[AuthScheme.refreshToken],
      expiresIn: json[AuthScheme.expiresIn],
    );
  }
}
