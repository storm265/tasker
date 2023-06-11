import 'package:flutter/cupertino.dart';
import 'package:todo2/domain/model/checklist_model.dart';

abstract class CheckListDataSource {
  Future<void> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  });

  Future<void> updateCheckList({
    required String checklistId,
    List<Map<String, dynamic>>? items,
    required String title,
    required Color color,
  });
  Future<void> deleteCheckList({required CheckListModel checkListModel});

  Future<void> deleteCheckListItem({required String checkListId});

  Future<void> deleteCheckListItems({required List<String>? items});

  Future<List<dynamic>> fetchAllCheckLists();
}
