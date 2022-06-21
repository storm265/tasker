import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/check_list_items.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class ChecklistItemsDataSource {
  Future putCheckListItem({
    required String content,
    required int checklistId,
    required bool isCompleted,
  });
  Future fetchChecklistItem();
}
// TODO: Inject dependencies
class ChecklistItemsDataSourceImpl implements ChecklistItemsDataSource {
  final _table = 'checklist_items';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<PostgrestResponse<dynamic>> putCheckListItem({
    required String content,
    required int checklistId,
    required bool isCompleted,
  }) async {
    try {
      final response = await _supabase.from(_table).insert({
        CheckListItemsScheme.content: content,
        CheckListItemsScheme.checklistId: checklistId,
        CheckListItemsScheme.isCompleted: isCompleted,
        CheckListItemsScheme.ownerId: _supabase.auth.currentUser!.id,
      }).execute();
      return response;
    } catch (e) {
      rethrow;
    }
  
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchChecklistItem() async {
    try {
      final response = await _supabase
          .from(_table)
          .select(
              '${CheckListItemsScheme.content},${CheckListItemsScheme.isCompleted},${CheckListItemsScheme.checklistId}')
          .eq(CheckListItemsScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      rethrow;
    }
   
  }
}
