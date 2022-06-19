// ignore_for_file: non_constant_identifier_names

import 'dart:core';

class UserModel {
  String email, password, created_at, uid;
  UserModel({
    required this.email,
    required this.uid,
    required this.password,
    required this.created_at,
  });
}
