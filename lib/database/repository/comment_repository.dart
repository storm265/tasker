import 'package:todo2/database/data_source/comment_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TasksMembersRepository {
  Future postComment({required String content});
}

class TasksMembersRepositoryImpl implements TasksMembersRepository {
  //final _commentDataSource = CommentDataSourceImpl();

  @override
  Future<void> postComment({required String content}) async {
    try {
      //   await _commentDataSource.postComment(content: content);
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
