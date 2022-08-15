import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:todo2/database/database_scheme/storage_scheme.dart';
import 'package:todo2/database/database_scheme/task_attachments_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';

import 'package:todo2/services/network_service/network_config.dart';

abstract class TaskAttachmentsDataSource {
  Future postAttachment({
    required String url,
    required int taskId,
  });
  Future uploadFile({
    required String path,
    required File file,
  });
  Future fetchAttachment();
  Future fetchAvatar();
}

class TaskAttachmentsDataSourceImpl implements TaskAttachmentsDataSource {
  final String _table = 'task_attachment';
  final _supabase = NetworkSource().networkApiClient;

  @override
  Future<Response<dynamic>> postAttachment(
      {required String url, required int taskId}) async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   TaskAttachmentsScheme.url: url,
      //   TaskAttachmentsScheme.taskId: taskId,
      //   TaskAttachmentsScheme.createdAt: DateTime.now().toString()
      // }).execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> fetchAttachment() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select()
      //     .eq(TaskAttachmentsScheme.taskId, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> uploadFile({required String path, required File file}) async {
    try {
      // await _supabase.storage.from(StorageScheme.avatar).upload(path, file);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> fetchAvatar() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(StorageScheme.avatarUrl)
      //     .eq(StorageScheme.avatar, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
