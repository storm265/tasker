import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/tasks_member_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class TasksMembersDataSource {
  Future putMember();
}

class TasksMembersDataSourceImpl implements TasksMembersDataSource {
  final String _table = 'task_member';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<PostgrestResponse<dynamic>> putMember() async {
    try {
      final response = await _supabase.from(_table).insert({
        TasksMemberScheme.createdAt: DateTime.now().toString(),
      }).execute();
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in TasksMembersDataSourceImpl putMember() :$e');
      rethrow;
    }
  }
}
