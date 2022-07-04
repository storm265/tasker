import 'dart:core';

class UserModel {
  String email;
  String password;
  String ownerId;
  String createdAt;

  UserModel({
    required this.email,
    required this.ownerId,
    required this.password,
    required this.createdAt,
  });
}
