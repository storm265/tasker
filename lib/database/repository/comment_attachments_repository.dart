import 'dart:developer';

import 'package:todo2/database/data_source/comment_attachments_data_source.dart';
import 'package:todo2/database/data_source/task_attachments_data_source.dart';
import 'package:todo2/database/model/comment_attachment_model.dart';
import 'package:todo2/database/model/task_attachments_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class CommentAttachmentRepository {
  Future putAttachment({required String url, required String commentId});
}

class CommentAttachmentRepositoryImpl implements CommentAttachmentRepository {
  final _taskAttachmentDataSource = CommentAttachmentDataSourceImpl();
  @override
  Future<List<CommentAattachmentModel>> putAttachment({
    required String url,
    required String commentId,
  }) async {
    try {
      final response = await _taskAttachmentDataSource.putCommentAttachment(
        url: url,
        commentId: commentId,
      );
      return (response.data as List<dynamic>)
          .map((json) => CommentAattachmentModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in CommentAttachmentRepositoryImpl putAttachment() : $e');
      rethrow;
    }
  }
}
