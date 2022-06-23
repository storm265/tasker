import 'dart:core';

class UserModel {
  String email;
  String password;
  String uuid;
  String createdAt;
  
  UserModel({
    required this.email,
    required this.uuid,
    required this.password,
    required this.createdAt,
  });
}
