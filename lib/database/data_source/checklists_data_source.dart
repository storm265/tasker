import 'dart:developer';
import 'package:dio/dio.dart';
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
      log('data $title, ${color.toString().toStringColor()}, $id, ${items!.length}');
      final response = await _network.networkApiClient.post(
        path: _checklists,
        data: {
          CheckListsScheme.title: title,
          CheckListsScheme.color: color.toString().toStringColor(),
          CheckListsScheme.ownerId: id,
          CheckListsScheme.items: items,
        },
        options: await _network.networkApiClient
            .getLocalRequestOptions(useContentType: true),
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
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.networkApiClient.put(
        path: '$_checklists/${checkListModel.id}',
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
      final response = await _network.networkApiClient.delete(
        path: '$_checklistsItems/$checkListId',
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
      final response = await _network.networkApiClient.delete(
        path: _checklistsItems,
        queryParameters: {
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

      final response = await _network.networkApiClient.delete(
        path: '$_checklists/$id',
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
      // final response = await _network.networkApiClient.get(
      //   path: '$_checklists/$ownerId',
      //   options: await _network.networkApiClient.getLocalRequestOptions(),
      // );
      // log('fetchAllCheckLists ${response.data}');
      // log('fetchAllCheckLists ${response.statusMessage}');
      final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            "data": [
              {
                "id": "b4e49d06-8223-4b1f-a6d1-6cdf4f115231",
                "title": "checklist 2",
                "color": "#5ABB56",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "items": [],
                "created_at": "2022-07-13T08:57:49.485633"
              },
              {
                "id": "1f42ad13-06a9-4b48-adc9-787d9e8b929c",
                "title": "checklist 1.1",
                "color": "#6074F9",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "items": [
                  {
                    "id": "cbf03617-8ccf-480e-9be4-ae65fdff8594",
                    "content": "asdsad asd111111",
                    "checklist_id": "1f42ad13-06a9-4b48-adc9-787d9e8b929c",
                    "is_completed": true,
                    "created_at": "2022-07-13T08:57:12.669766"
                  },
                  {
                    "id": "3ec81aae-df2b-4cc1-8411-d5261bafd841",
                    "content": "qweqweqwe11111",
                    "checklist_id": "1f42ad13-06a9-4b48-adc9-787d9e8b929c",
                    "is_completed": false,
                    "created_at": "2022-07-13T08:57:12.670581"
                  }
                ],
                "created_at": "2022-07-13T08:57:12.648075"
              },
              {
                "id": "1f42ad13-06a9-4b48-adc9-787d9e8b929c",
                "title": "checklist 1.1",
                "color": "#6074F9",
                "owner_id": "76d2fab4-fd06-4909-bf8e-875c6b55c1f7",
                "items": [
                  {
                    "id": "cbf03617-8ccf-480e-9be4-ae65fdff8594",
                    "content": "asdsad asd111111",
                    "checklist_id": "1f42ad13-06a9-4b48-adc9-787d9e8b929c",
                    "is_completed": true,
                    "created_at": "2022-07-13T08:57:12.669766"
                  },
                  {
                    "id": "3ec81aae-df2b-4cc1-8411-d5261bafd841",
                    "content": "qweqweqwe11111",
                    "checklist_id": "1f42ad13-06a9-4b48-adc9-787d9e8b929c",
                    "is_completed": false,
                    "created_at": "2022-07-13T08:57:12.670581"
                  }
                ],
                "created_at": "2022-07-13T08:57:12.648075"
              }
            ]
          });
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![CheckListsScheme.data] as List<dynamic>)
          : throw Failure('Error: fetchAllCheckLists error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
