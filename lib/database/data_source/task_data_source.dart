import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/task_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class TaskDataSource{
  Future fetchTask();
}
class TaskDataSourceImpl implements TaskDataSource{
  final String _table = 'tasks';
    final _supabase = SupabaseSource().restApiClient;
  @override
  Future<PostgrestResponse<dynamic>> fetchTask() async{
       try {
      final response = await _supabase
          .from(_table)
          .select('*')
          .eq(TaskScheme.uuid, _supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectUserDataImpl fetchProject() dataSource:  $e');
      rethrow;
    }
  }

}
