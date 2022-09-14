import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/database_scheme/checklists_scheme.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

abstract class CheckListsDataSource {
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

  Future<void> deleteCheckListItems({required List<String>? items});

  Future<List<dynamic>> fetchAllCheckLists();
}

class CheckListsDataSourceImpl extends CheckListsDataSource {
  final NetworkSource _network;
  final SecureStorageSource _secureStorage;

  CheckListsDataSourceImpl({
    required NetworkSource network,
    required SecureStorageSource secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

  final _userChecklists = '/user-checklists';
  final _checklists = '/checklists';
  final _checklistsItems = '/checklists-items';

  @override
  Future<void> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
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
      log('createCheckList ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateCheckList({
    required CheckListModel checkListModel,
    List<Map<String, dynamic>>? items,
    required String title,
    required Color color,
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);

      log(' update : $_checklists/${checkListModel.id}');
      final response = await _network.put(
        path: '$_checklists/${checkListModel.id}',
        data: {
          CheckListsScheme.title: title,
          CheckListsScheme.color: color.toString().toStringColor(),
          CheckListsScheme.ownerId: ownerId,
          CheckListsScheme.items: items ?? [],
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('updateCheckList ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckListItem({required String checkListId}) async {
    try {
      final response = await _network.delete(
        path: '$_checklistsItems/$checkListId',
        options: await _network.getLocalRequestOptions(),
      );
      log('deleteCheckList ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckListItems({required List<String>? items}) async {
    try {
      final response = await _network.delete(
        path: _checklistsItems,
        data: {
          CheckListsScheme.items: items ?? {},
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('deleteCheckListItems ${response.data}');
      log('deleteCheckListItems ${response.statusMessage}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckList({required CheckListModel checkListModel}) async {
    try {
      log('id ${checkListModel.id}');
      final response = await _network.delete(
        path: '$_checklists/${checkListModel.id}',
        options: await _network.getLocalRequestOptions(),
      );
      log('deleteCheckList ${response.statusCode}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchAllCheckLists() async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.get(
        path: '$_userChecklists/$ownerId',
        options: await _network.getLocalRequestOptions(),
      );
      debugPrint('fetchAllCheckLists ${response.data}');

      return NetworkErrorService.isSuccessful(response)
          ? (response.data![CheckListsScheme.data] as List<dynamic>)
          : throw Failure('fetchAllCheckLists error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
