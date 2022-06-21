import 'package:todo2/database/data_source/checklist_items_data_source.dart';
import 'package:todo2/database/model/checklist_item_model.dart';

abstract class ChecklistItemsRepository<T> {
  Future putChecklistItem({required List<String> checkboxItems});
  Future fetchChecklistItem();
}

class ChecklistItemsRepositoryImpl
    implements ChecklistItemsRepository<CheckListItemModel> {
  final _checkListItemDataSource = ChecklistItemsDataSourceImpl();
  @override
  Future<void> putChecklistItem({required List<String> checkboxItems}) async {
    try {
      for (int i = 0; i < checkboxItems.length; i++) {
        await _checkListItemDataSource.putCheckListItem(
          content: checkboxItems[i],
          checklistId: i,
          isCompleted: false,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CheckListItemModel>> fetchChecklistItem() async {
    // TODO: why dynamic?
    try {
      final response = await _checkListItemDataSource.fetchChecklistItem();
      final data = (response.data as List<dynamic>)
          .map((json) => CheckListItemModel.fromJson(json))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
