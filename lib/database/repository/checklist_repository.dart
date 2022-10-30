import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/model/checklist_model.dart';

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

class CheckListRepositoryImpl extends CheckListRepository {
  CheckListRepositoryImpl(
      {required CheckListsDataSourceImpl checkListsDataSource})
      : _checkListsDataSource = checkListsDataSource;
  final CheckListsDataSourceImpl _checkListsDataSource;

  @override
  Future<CheckListModel> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  }) async {
    final response = await _checkListsDataSource.createCheckList(
      title: title,
      color: color,
      items: items,
    );
    return CheckListModel.fromJson(response);
  }

  @override
  Future<void> deleteCheckList({required CheckListModel checkListModel}) async {
    await _checkListsDataSource.deleteCheckList(checkListModel: checkListModel);
  }

  @override
  Future<void> deleteCheckListItem({required String checkListId}) async =>
      await _checkListsDataSource.deleteCheckListItem(checkListId: checkListId);

  @override
  Future<void> deleteCheckListItems({required List<String> items}) async =>
      await _checkListsDataSource.deleteCheckListItems(items: items);

// TODO dont save key
  @override
  Future<List<CheckListModel>> fetchAllCheckLists() async {
    final response = await _checkListsDataSource.fetchAllCheckLists();
    List<CheckListModel> statsModels = [];
    for (int i = 0; i < response.length; i++) {
      statsModels.add(CheckListModel.fromJson(response[i]));
    }

    return statsModels;
  }

  @override
  Future<CheckListModel> updateCheckList({
    required String checklistId,
    List<Map<String, dynamic>>? items,
    required String title,
    required Color color,
  }) async {
    final response = await _checkListsDataSource.updateCheckList(
      checklistId: checklistId,
      items: items,
      title: title,
      color: color,
    );
    return CheckListModel.fromJson(response);
  }
}
