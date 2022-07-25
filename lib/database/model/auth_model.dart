import 'dart:collection';

import 'package:todo2/database/database_scheme/auth_scheme.dart';

class AuthModel {
  String accessToken;
  String refreshToken;
  String expiresIn;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
  factory AuthModel.fromJson(LinkedHashMap<String, dynamic> json) {
    return AuthModel(
      accessToken: json[AuthScheme.accessToken],
      refreshToken: json[AuthScheme.refreshToken],
      expiresIn: json[AuthScheme.expiresIn],
    );
  }
}
