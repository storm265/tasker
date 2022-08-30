import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

abstract class CheckListsRepository<T> {
  Future<void> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  });

  Future<void> updateCheckList({
    required CheckListModel checkListModel,
    List<Map<String, dynamic>>? items,
  });
  Future<void> deleteCheckList();

  Future<void> deleteCheckListItem({required String checkListId});

  Future<void> deleteCheckListItems({required List<String>? items});

  Future<List<CheckListModel>> fetchAllCheckLists();
}

class CheckListsRepositoryImpl extends CheckListsRepository<CheckListModel> {
  CheckListsRepositoryImpl(
      {required CheckListsDataSourceImpl checkListsDataSource})
      : _checkListsDataSource = checkListsDataSource;
  final CheckListsDataSourceImpl _checkListsDataSource;

  @override
  Future<void> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      await _checkListsDataSource.createCheckList(
        title: title,
        color: color,
        items: items,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckList() async {
    try {
      await _checkListsDataSource.deleteCheckList();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckListItem({required String checkListId}) async {
    try {
      await _checkListsDataSource.deleteCheckListItem(checkListId: checkListId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckListItems({required List<String>? items}) async {
    try {
      await _checkListsDataSource.deleteCheckListItems(items: items);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<CheckListModel>> fetchAllCheckLists() async {
    try {
      throw Failure('.toString(e)');
      // final response = await _checkListsDataSource.fetchAllCheckLists();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateCheckList({
    required CheckListModel checkListModel,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      await _checkListsDataSource.updateCheckList(
        checkListModel: checkListModel,
        items: items,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
