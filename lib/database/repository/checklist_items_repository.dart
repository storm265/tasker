import 'dart:developer';

import 'package:todo2/database/data_source/checklist_items_data_source.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class ChecklistItemsRepository<T> {
  Future putChecklistItem({required List<String> checkboxItems, required int id}) ;
  Future fetchCheckListItem();
}

class ChecklistItemsRepositoryImpl
    implements ChecklistItemsRepository<CheckListItemModel> {
  final _checkListItemDataSource = ChecklistItemsDataSourceImpl();
  @override
  Future<void> putChecklistItem({required List<String> checkboxItems, required int id}) async {
    try {
      for (int i = 0; i < checkboxItems.length; i++) {
        await _checkListItemDataSource.putCheckListItem(
          content: checkboxItems[i],
          // TODO fix id
          checklistId: id,
          isCompleted: false,
        );
      }
    } catch (e) {
      ErrorService.printError('Error in repository putChecklistItem: $e');
      rethrow;
    }
  }

  @override
  Future<List<CheckListItemModel>> fetchCheckListItem() async {
    try {
      final response = await _checkListItemDataSource.fetchChecklistItem();
      if (response.hasError) {
        log(response.error!.message);
      }
      return (response.data as List<dynamic>)
          .map((json) => CheckListItemModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchChecklistItem() repository:$e');
      rethrow;
    }
  }
}
