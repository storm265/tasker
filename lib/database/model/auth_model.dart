import 'dart:developer';

import 'package:dio/dio.dart';
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

  factory AuthModel.fromJson(
      {required Map<String, dynamic> json,
      required Response response,
      bool isSignUp = false}) {
    return AuthModel(
      id: json[AuthScheme.id] ?? 'null',
      userId: json[AuthScheme.userId] ?? 'null',
      accessToken: isSignUp
          ? response.data[AuthScheme.data][AuthScheme.userSession]
              [AuthScheme.accessToken]
          : response.data[AuthScheme.data][AuthScheme.accessToken] ?? 'null',
      refreshToken: isSignUp
          ? response.data[AuthScheme.data][AuthScheme.userSession]
              [AuthScheme.refreshToken]
          : response.data[AuthScheme.data][AuthScheme.refreshToken] ?? 'null',
      expiresIn: response.data[AuthScheme.data][AuthScheme.expiresIn] ?? 0,
    );
  }
}
