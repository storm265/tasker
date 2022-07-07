import 'package:todo2/database/data_source/comment_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TasksMembersRepository {
  Future putComment({required String content});
}

class TasksMembersRepositoryImpl implements TasksMembersRepository {
  final _commentDataSource = CommentDataSourceImpl();

  @override
  Future<void> putComment({required String content}) async {
    try {
      await _commentDataSource.putComment(content: content);
    } catch (e) {
      ErrorService.printError(
          'Error in TasksMembersRepositoryImpl putComment() :$e');
      rethrow;
    }
  }
}
