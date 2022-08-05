import 'package:dio/dio.dart';
import 'package:todo2/database/database_scheme/tasks_member_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';

abstract class TasksMembersDataSource {
  Future putMember();
}

class TasksMembersDataSourceImpl implements TasksMembersDataSource {
  final String _table = 'task_member';
  final _supabase = NetworkSource().networkApiClient;

  @override
  Future<Response<dynamic>> putMember() async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   TasksMemberScheme.createdAt: DateTime.now().toString(),
      // }).execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in TasksMembersDataSourceImpl putMember() :$e');
      rethrow;
    }
  }
}
