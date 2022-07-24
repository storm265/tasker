import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';

abstract class ChecklistItemsDataSource {
  Future putCheckListItem({
    required String content,
    required int checklistId,
    required bool isCompleted,
  });
  Future fetchChecklistItem();
}

class ChecklistItemsDataSourceImpl implements ChecklistItemsDataSource {
  final _table = 'checklist_items';
  final _supabase = NetworkSource().networkApiClient;

  @override
  Future<PostgrestResponse<dynamic>> putCheckListItem({
    required String content,
    required int checklistId,
    required bool isCompleted,
  }) async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   CheckListItemsScheme.content: content,
      //   CheckListItemsScheme.checklistId: checklistId,
      //   CheckListItemsScheme.isCompleted: isCompleted,
      //   CheckListItemsScheme.ownerId: _supabase.auth.currentUser!.id,
      //   CheckListItemsScheme.createdAt: DateTime.now().toString(),
      // }).execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in ChecklistItemsDataSourceImpl putCheckListItem: $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchChecklistItem() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(
      //         '${CheckListItemsScheme.content},${CheckListItemsScheme.isCompleted},${CheckListItemsScheme.checklistId}')
      //     .eq(CheckListItemsScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError(
          'Error in ChecklistItemsDataSourceImpl fetchChecklistItem: $e');
      rethrow;
    }
  }
}
