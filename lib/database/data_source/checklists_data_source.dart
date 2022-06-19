import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/checklists_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class CheckListsDataSource<T> {
  Future<T> putCheckList({
    required String title,
    required String color,
  });
  Future<T> fetchCheckList();
}

class CheckListsDataSourceImpl extends CheckListsDataSource {
  final _table = 'checklists';
  final _supabase = SupabaseSource().dbClient;
  @override
  Future<PostgrestResponse<dynamic>> putCheckList({
    required String title,
    required String color,
  }) async {
    try {
      final _responce = await _supabase.from(_table).insert({
        CheckListsScheme.title: title,
        CheckListsScheme.color: color,
        CheckListsScheme.createdAt: DateTime.now().toString(),
        CheckListsScheme.ownerId: _supabase.auth.currentUser!.id,
      }).execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in data source putCheckList: $e');
    }
    throw Exception('Error in data source putCheckList');
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchCheckList() async {
    try {
      final _responce = await _supabase
          .from(_table)
          .select('${CheckListsScheme.title},${CheckListsScheme.color}')
          .eq(CheckListsScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() data source:$e');
    }
    return throw Exception('Error in fetchNotes() data source');
  }
}
