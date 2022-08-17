import 'package:todo2/database/data_source/tasks_members_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class TasksMembersRepository {
  Future putMember();
}

class TasksMembersRepositoryImpl implements TasksMembersRepository {
  final _tasksMembersDataSource = TasksMembersDataSourceImpl();

  @override
  Future<void> putMember() async {
    try {
      await _tasksMembersDataSource.putMember();
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
