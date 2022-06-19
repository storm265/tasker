import 'dart:developer';

import 'package:todo2/database/data_source/checklist_items_data_source.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class ChecklistItemsRepository<T> {
  Future<T> putChecklistItem({required List<String> checkboxItems});
  Future<T> fetchChecklistItem();
}

class ChecklistItemsRepositoryImpl implements ChecklistItemsRepository {
  final _checkListItemDataSource = ChecklistItemsDataSourceImpl();
  @override
  Future<void> putChecklistItem({required List<String> checkboxItems}) async {
    try {
      for (int i = 0; i < checkboxItems.length; i++) {
        await _checkListItemDataSource.putChecklistItem(
          content: checkboxItems[i],
          checklistId: i,
          isCompleted: false,
        );
      }
    } catch (e) {
      ErrorService.printError('Error in repository putChecklistItem: $e');
    }
  }

  @override
  Future<List<CheckListItemModel>> fetchChecklistItem() async {
    try {
      final _responce = await _checkListItemDataSource.fetchChecklistItem();
      log(_responce.data);
      return (_responce.data as List<dynamic>)
          .map((json) => CheckListItemModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchChecklistItem() repository:$e');
    }
    throw Exception('Error in fetchChecklistItem() repository');
  }

  Future<void> getList() async {
    final _responce = await _checkListItemDataSource.fetchChecklistItem();
    final data = await _responce.data;
    log(data.toString());
  }
}
