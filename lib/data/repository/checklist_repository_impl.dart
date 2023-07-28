import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo2/data/data_source/checklist/checklist_data_source_impl.dart';
import 'package:todo2/domain/model/checklist_model.dart';
import 'package:todo2/domain/repository/checklist_repository.dart';
import 'package:todo2/schemas/checklists/checklist/checklist_dao_impl.dart';
import 'package:todo2/schemas/checklists/checklist/checklist_database.dart';
import 'package:todo2/schemas/checklists/checklist_item/checklist_item_dao.dart';
import 'package:todo2/schemas/checklists/checklist_item/checklist_item_database.dart';
import 'package:todo2/schemas/database_scheme/checklists_scheme.dart';
import 'package:todo2/services/cache_service/cache_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class CheckListRepositoryImpl extends CheckListRepository {
  CheckListRepositoryImpl({
    required CheckListDataSourceImpl checkListsDataSource,
    required CheckListDao checklistDao,
    required CheckListItemDao checklistItemDao,
    required InMemoryCache inMemoryCache,
  })  : _checkListsDataSource = checkListsDataSource,
        _checklistDao = checklistDao,
        _checklistItemDao = checklistItemDao,
        _inMemoryCache = inMemoryCache;

  final CheckListDataSourceImpl _checkListsDataSource;

  final InMemoryCache _inMemoryCache;

  final CheckListDao _checklistDao;

  final CheckListItemDao _checklistItemDao;

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

  @override
  Future<List<CheckListModel>> fetchAllCheckLists() async {
    final List<Map<String, dynamic>> emptyList = [];
    List<CheckListModel> checklistModels = [];
    if (_inMemoryCache.shouldFetchOnlineData(
      date: DateTime.now(),
      key: CacheKeys.quick,
      isSaveKey: false,
    )) {
      final response = await _checkListsDataSource.fetchAllCheckLists();
      await _checklistDao.deleteAllChecklists();
      await _checklistItemDao.deleteAllChecklistItems();

      for (int i = 0; i < response.length; i++) {
        checklistModels.add(CheckListModel.fromJson(response[i]));
        await _checklistDao.insertChecklist(
          CheckListTableCompanion(
            id: Value(checklistModels[i].id),
            ownerId: Value(checklistModels[i].ownerId),
            title: Value(checklistModels[i].title),
            color: Value(checklistModels[i].color.toString().toStringColor()),
            createdAt: Value(checklistModels[i].createdAt.toIso8601String()),
          ),
        );
      }

      for (var i = 0; i < checklistModels.length; i++) {
        for (var element in checklistModels.elementAt(i).items) {
          await _checklistItemDao.insertChecklistItem(
            CheckListItemTableCompanion(
              checklistId: Value(element.checklistId ?? ''),
              content: Value(element.content),
              isCompleted: Value(element.isCompleted),
              id: Value(element.id ?? ''),
              createdAt: Value(element.createdAt?.toIso8601String() ?? ''),
            ),
          );
        }
      }
      return checklistModels;
    } else {
      final checklists = await _checklistDao.getChecklists();
      final items = await _checklistItemDao.getChecklistItems();

      for (int i = 0; i < checklists.length; i++) {
        List<Map<String, dynamic>> mappedItems = [];
        final listItemsById = items
            .where((element) => element.checklistId == checklists[i].id)
            .toList();
        for (int j = 0; j < listItemsById.length; j++) {
          mappedItems.add(listItemsById[j].toJson());
        }

        checklistModels.add(
          CheckListModel.fromJson({
            CheckListsScheme.id: checklists[i].id,
            CheckListsScheme.title: checklists[i].title,
            CheckListsScheme.ownerId: checklists[i].ownerId,
            CheckListsScheme.color: checklists[i].color,
            CheckListsScheme.createdAt: checklists[i].createdAt,
            CheckListsScheme.items:
                listItemsById.isEmpty ? emptyList : mappedItems,
          }),
        );
      }

      return checklistModels;
    }
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
