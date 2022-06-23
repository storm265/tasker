import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/checklists_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class CheckListsDataSource {
  Future putCheckList({
    required String title,
    required String color,
  });
  Future fetchCheckList();
}

class CheckListsDataSourceImpl extends CheckListsDataSource {
  final _table = 'checklists';
  final _supabase = SupabaseSource().restApiClient;
  @override
  Future<PostgrestResponse<dynamic>> putCheckList({
    required String title,
    required String color,
  }) async {
    try {
      final response = await _supabase.from(_table).insert({
        CheckListsScheme.title: title,
        CheckListsScheme.color: color,
        CheckListsScheme.uuid: _supabase.auth.currentUser!.id,
        CheckListsScheme.createdAt: DateTime.now().toString(),
      }).execute();
      return response;
    } catch (e) {
      ErrorService.printError('Error in data source putChecklistItem: $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchCheckList() async {
    try {
      final response = await _supabase
          .from(_table)
          .select('${CheckListsScheme.title},${CheckListsScheme.color}')
          .eq(CheckListsScheme.uuid, _supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      ErrorService.printError('Error in data source fetchCheckList: $e');
      rethrow;
    }
  }
}
