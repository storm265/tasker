import 'dart:developer';
import 'dart:io';
import 'package:todo2/database/data_source/task_attachment_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TaskAttachmentRepository {
  Future putAttachment({required String url,required int taskId});
  Future uploadFile({required String path, required File file});
}

class TaskAttachmentRepositoryImpl implements TaskAttachmentRepository {
  final _taskAttachmentDataSource = TaskAttachmentsDataSourceImpl();
  @override
  Future<void> putAttachment({required String url,required int taskId}) async {
    try {
      final response = await _taskAttachmentDataSource.putAttachment(url: url,taskId: taskId);
      if (response.hasError) {
        log(response.error!.message);
      }
    } catch (e) {
      ErrorService.printError(
          'Error in TaskAttachmentsRepositoryImpl putAttachment() : $e');
      rethrow;
    }
  }
  

  @override
  Future<void> uploadFile({required String path, required File file}) async {
    try {
      await _taskAttachmentDataSource.uploadFile(path: path, file: file);
    } catch (e) {
      ErrorService.printError(
          'TaskAttachmentsRepositoryImpl uploadAvatar error: $e');
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
