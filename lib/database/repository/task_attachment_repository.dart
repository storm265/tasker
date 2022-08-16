import 'dart:io';
import 'package:todo2/database/data_source/task_attachment_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TaskAttachmentRepository {
  Future postAttachment({required String url, required int taskId});
  Future uploadFile({required String path, required File file});
}

class TaskAttachmentRepositoryImpl implements TaskAttachmentRepository {
  final _taskAttachmentDataSource = TaskAttachmentsDataSourceImpl();
  @override
  Future<void> postAttachment(
      {required String url, required int taskId}) async {
    try {
      await _taskAttachmentDataSource.postAttachment(
        url: url,
        taskId: taskId,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> uploadFile({required String path, required File file}) async {
    try {
      await _taskAttachmentDataSource.uploadFile(path: path, file: file);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  //   Future<void> uploadAvatar() async {
  //   try {
  //     if (pickedFile.value.path.contains('assets')) {
  //       ErrorService.printError('Pick image!');
  //     } else {
  //       await _supabase.storage.from('avatar').upload(
  //             pickedFile.value.name,
  //             File(pickedFile.value.path),
  //           );
  //     }
  //   } catch (e) {
  //     ErrorService.printError('uploadAvatar error: $e');
  //   }
  // }
}
