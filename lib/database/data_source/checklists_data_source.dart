import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/database_scheme/checklists_scheme.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
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
  });
  Future<void> deleteCheckList();

  Future<void> deleteCheckListItem({required String checkListId});

  Future<void> deleteCheckListItems({required List<String>? items});

  Future<List<dynamic>> fetchAllCheckLists();
}

class CheckListsDataSourceImpl extends CheckListsDataSource {
  final NetworkSource _network;
  final SecureStorageService _secureStorage;
  CheckListsDataSourceImpl({
    required NetworkSource network,
    required SecureStorageService secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

  final _checklists = 'checklists';
  final _checklistsItems = 'checklists-items';

  @override
  Future<void> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      final id = await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.post(
        _checklists,
        data: {
          CheckListsScheme.title: title,
          CheckListsScheme.color: color.toString().toStringColor(),
          CheckListsScheme.ownerId: id,
          CheckListsScheme.items: items ?? [],
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
      log('createCheckList ${response.data}');
      log('createCheckList ${response.statusMessage}');
    } catch (e) {
      log('create ');
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateCheckList({
    required CheckListModel checkListModel,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.put(
        '$_checklists/${checkListModel.id}',
        data: {
          CheckListsScheme.title: checkListModel.title,
          CheckListsScheme.color:
              checkListModel.color.toString().toStringColor(),
          CheckListsScheme.ownerId: ownerId,
          CheckListsScheme.items: items ?? [],
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
      log('updateCheckList ${response.data}');
      log('updateCheckList ${response.statusMessage}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckListItem({required String checkListId}) async {
    try {
      final response = await _network.networkApiClient.dio.delete(
        '$_checklistsItems/$checkListId',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
      log('deleteCheckList ${response.data}');
      log('deleteCheckList ${response.statusMessage}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckListItems({required List<String>? items}) async {
    try {
      final response = await _network.networkApiClient.dio.delete(
        _checklistsItems,
        data: {
          CheckListsScheme.items: items ?? [],
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
      );
      log('deleteCheckListItems ${response.data}');
      log('deleteCheckListItems ${response.statusMessage}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteCheckList() async {
    try {
      final id = await _secureStorage.getUserData(type: StorageDataType.id);

      final response = await _network.networkApiClient.dio.delete(
        ' $_checklists/$id',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
      log('deleteCheckList ${response.data}');
      log('deleteCheckList ${response.statusMessage}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchAllCheckLists() async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.dio.get(
        '$_checklists/$ownerId',
        options: await _network.networkApiClient.getLocalRequestOptions(),
      );
      log('fetchAllCheckLists ${response.data}');
      log('fetchAllCheckLists ${response.statusMessage}');
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![CheckListsScheme.data] as List<dynamic>)
          : throw Failure('Error: fetchAllCheckLists error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
