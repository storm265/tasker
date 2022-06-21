import 'dart:core';

class UserModel {
  String email, password, createdAt, uid;
  UserModel({
    required this.email,
    required this.uid,
    required this.password,
    required this.createdAt,
  });
}
