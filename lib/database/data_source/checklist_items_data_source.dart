import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/check_list_items.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class ChecklistItemsDataSource<T> {
  Future<T> putChecklistItem({
    required String content,
    required int checklistId,
    required bool isCompleted,
  });
  Future<T> fetchChecklistItem();
   
}

class ChecklistItemsDataSourceImpl implements ChecklistItemsDataSource {
  final _table = 'checklist_items';
  final _supabase = SupabaseSource().dbClient;

  @override
  Future<PostgrestResponse<dynamic>> putChecklistItem({
    required String content,
    required int checklistId,
    required bool isCompleted,
  }) async {
    try {
      final _responce = await _supabase.from(_table).insert({
        CheckListItemsScheme.content: content,
        CheckListItemsScheme.checklistId: checklistId,
        CheckListItemsScheme.isCompleted: isCompleted,
        CheckListItemsScheme.ownerId: _supabase.auth.currentUser!.id,
      }).execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in data source putChecklistItem: $e');
    }
    throw Exception('Error in data source putChecklistItem');
  }
  
  @override
  Future<PostgrestResponse<dynamic>> fetchChecklistItem()async {
    try {
      final _responce = await _supabase
          .from(_table)
          .select('${CheckListItemsScheme.content},${CheckListItemsScheme.isCompleted},${CheckListItemsScheme.checklistId}')
          .eq(CheckListItemsScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
         
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() data source:$e');
    }
    return throw Exception('Error in fetchNotes() data source');
  }
}
