import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';

abstract class CheckListsRepository<T> {
  Future<void> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  });

  Future<void> updateCheckList({
    required CheckListModel checkListModel,
    List<Map<String, dynamic>>? items,
    required String title,
    required Color color,
  });
  Future<void> deleteCheckList({required CheckListModel checkListModel});

  Future<void> deleteCheckListItem({required String checkListId});

  Future<void> deleteCheckListItems({required List<String> items});

  Future<List<CheckListModel>> fetchAllCheckLists();
}

class CheckListRepositoryImpl extends CheckListsRepository<CheckListModel> {
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
    try {
      final response = await _checkListsDataSource.createCheckList(
        title: title,
        color: color,
        items: items,
      );
      return CheckListModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckList({required CheckListModel checkListModel}) async {
    try {
      await _checkListsDataSource.deleteCheckList(
          checkListModel: checkListModel);
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
  Future<void> deleteCheckListItems({required List<String> items}) async {
    try {
      await _checkListsDataSource.deleteCheckListItems(items: items);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<CheckListModel>> fetchAllCheckLists() async {
    try {
      final response = await _checkListsDataSource.fetchAllCheckLists();
      List<CheckListModel> statsModels = [];
      for (int i = 0; i < response.length; i++) {
        statsModels.add(CheckListModel.fromJson(response[i]));
      }
      log('model: $statsModels');
      return statsModels;
    } catch (e, t) {
      print('trace $t');
      throw Failure(e.toString());
    }
  }

  @override
  Future<CheckListModel> updateCheckList({
    required CheckListModel checkListModel,
    List<Map<String, dynamic>>? items,
    required String title,
    required Color color,
  }) async {
    try {
      final response = await _checkListsDataSource.updateCheckList(
        checkListModel: checkListModel,
        items: items,
        title: title,
        color: color,
      );
      return CheckListModel.fromJson(response);
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
