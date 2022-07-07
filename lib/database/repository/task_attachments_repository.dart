import 'dart:developer';

import 'package:todo2/database/data_source/task_attachments_data_source.dart';
import 'package:todo2/database/model/task_attachments_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TaskAttachmentsRepository {
  Future putAttachment({required String url});
}

class TaskAttachmentsRepositoryImpl implements TaskAttachmentsRepository {
  final _taskAttachmentDataSource = TaskAttachmentsDataSourceImpl();
  @override
  Future<List<TaskAttachmentModel>> putAttachment({required String url}) async {
    try {
      final response = await _taskAttachmentDataSource.putAttachment(url: url);
      if (response.hasError) {
        log(response.error!.message);
      }
      return (response.data as List<dynamic>)
          .map((json) => TaskAttachmentModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in TaskAttachmentsRepositoryImpl putAttachment() : $e');
      rethrow;
    }
  }
}
