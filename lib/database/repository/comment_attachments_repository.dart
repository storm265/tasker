import 'package:todo2/database/data_source/comment_attachments_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class CommentAttachmentRepository {
  Future putAttachment({required String url, required String commentId});
}

class CommentAttachmentRepositoryImpl implements CommentAttachmentRepository {
  //final _taskAttachmentDataSource = CommentAttachmentDataSourceImpl();

  @override
  Future<void> putAttachment({
    required String url,
    required String commentId,
  }) async {
    try {
      // await _taskAttachmentDataSource.putCommentAttachment(
      //   url: url,
      //   commentId: commentId,
      // );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
