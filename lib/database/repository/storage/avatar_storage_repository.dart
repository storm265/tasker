import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/storage/avatar_storage_data_source.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class AvatarStorageDataSource {
  Future uploadAvatar({
    required String name,
    required File file,
  });
}

class AvatarStorageReposiroryImpl implements AvatarStorageDataSource {
  final AvatarStorageDataSourceImpl avatarDataSource;

  AvatarStorageReposiroryImpl({required this.avatarDataSource});

  @override
  Future<String> uploadAvatar({
    required String name,
    required File file,
  }) async {
    try {
      final response = await avatarDataSource.uploadAvatar(
        name: name,
        file: file,
      );
      debugPrint('avatar url ${response[AuthScheme.avatarUrl]}');
      return response[AuthScheme.avatarUrl];
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
