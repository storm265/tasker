import 'package:flutter/material.dart';
import 'package:todo2/data/data_source/checklist/checklist_data_source.dart';
import 'package:todo2/domain/model/checklist_model.dart';
import 'package:todo2/schemas/database_scheme/checklists_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class CheckListDataSourceImpl extends CheckListDataSource {
  CheckListDataSourceImpl({
    required NetworkSource network,
    required SecureStorageSource secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

  final NetworkSource _network;

  final SecureStorageSource _secureStorage;

  final _userChecklists = '/user-checklists';
  final _checklists = '/checklists';
  final _checklistsItems = '/checklists-items';

  @override
  Future<Map<String, dynamic>> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  }) async {
    final id = await _secureStorage.getUserData(type: StorageDataType.id);
    final response = await _network.post(
      path: _checklists,
      data: {
        CheckListsScheme.title: title,
        CheckListsScheme.color: color.toString().toStringColor(),
        CheckListsScheme.ownerId: id,
        CheckListsScheme.items: items,
      },
      options: await _network.getLocalRequestOptions(useContentType: true),
    );
    return NetworkErrorService.isSuccessful(response)
        ? (response.data[CheckListsScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[CheckListsScheme.data][CheckListsScheme.message]}');
  }

  @override
  Future<Map<String, dynamic>> updateCheckList({
    required String checklistId,
    List<Map<String, dynamic>>? items,
    required String title,
    required Color color,
  }) async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);
    final response = await _network.put(
      path: '$_checklists/$checklistId',
      data: {
        CheckListsScheme.title: title,
        CheckListsScheme.color: color.toString().toStringColor(),
        CheckListsScheme.ownerId: ownerId,
        CheckListsScheme.items: items,
      },
      options: await _network.getLocalRequestOptions(useContentType: true),
    );

    return NetworkErrorService.isSuccessful(response)
        ? (response.data[CheckListsScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[CheckListsScheme.data][CheckListsScheme.message]}');
  }

  @override
  Future<void> deleteCheckListItem({required String checkListId}) async =>
      await _network.delete(
        path: '$_checklistsItems/$checkListId',
        options: await _network.getLocalRequestOptions(),
      );

  @override
  Future<void> deleteCheckListItems({required List<String>? items}) async =>
      await _network.delete(
        path: _checklistsItems,
        data: {
          CheckListsScheme.items: items ?? {},
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );

  @override
  Future<void> deleteCheckList(
          {required CheckListModel checkListModel}) async =>
      await _network.delete(
        path: '$_checklists/${checkListModel.id}',
        options: await _network.getLocalRequestOptions(),
      );

  @override
  Future<List<dynamic>> fetchAllCheckLists() async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);
    final response = await _network.get(
      path: '$_userChecklists/$ownerId',
      options: await _network.getLocalRequestOptions(),
    );
    debugPrint('fetchAllCheckLists ${response.data}');

    return NetworkErrorService.isSuccessful(response)
        ? (response.data![CheckListsScheme.data] as List<dynamic>)
        : throw Failure('fetchAllCheckLists error');
  }
}
