import 'package:flutter/material.dart';
import 'package:todo2/domain/model/checklist_model.dart';

abstract class CheckListRepository {
  Future<CheckListModel> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  });

  Future<void> deleteCheckList({required CheckListModel checkListModel});

  Future<void> deleteCheckListItem({required String checkListId});

  Future<void> deleteCheckListItems({required List<String> items});

  Future<List<CheckListModel>> fetchAllCheckLists();

  Future<CheckListModel> updateCheckList({
    required String checklistId,
    List<Map<String, dynamic>>? items,
    required String title,
    required Color color,
  });
}
