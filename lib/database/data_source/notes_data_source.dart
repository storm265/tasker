import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/database_scheme/notes_scheme.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

abstract class NotesDataSource {
  Future<void> createNote({
    required Color color,
    required String description,
  });

  Future<void> deleteNote({required String projectId});

  // Future<Map<String, dynamic>> fetchOneNote({required String projectId});

  Future<List<dynamic>> fetchUserNotes();

  Future<void> updateNote({required NotesModel noteModel});
}

class NotesDataSourceImpl implements NotesDataSource {
  final NetworkSource _network;
  final SecureStorageSource _secureStorage;

  NotesDataSourceImpl({
    required NetworkSource network,
    required SecureStorageSource secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

  final _notes = '/notes';

  @override
  Future<void> createNote({
    required Color color,
    required String description,
  }) async {
    try {
      final id = await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.post(
        path: _notes,
        data: {
          NotesScheme.description: description,
          NotesScheme.color: color.toString().toStringColor(),
          NotesScheme.ownerId: id,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('createNote ${response.data}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteNote({required String projectId}) async {
    try {
      final response = await _network.delete(
        path: '$_notes/$projectId',
        options: await _network.getLocalRequestOptions(),
      );
      log('deleteNote ${response.data}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchUserNotes() async {
    try {
      // final ownerId =
      //     await _secureStorage.getUserData(type: StorageDataType.id);
      // final response = await _network.get(
      //   path: '$_notes/$ownerId',
      //   queryParameters: {
      //     NotesScheme.ownerId: ownerId,
      //   },
      //   options: await _network
      //       .getLocalRequestOptions(useContentType: true),
      // );
      // log('fetchUserNotes ${response.data}');
      // log('fetchUserNotes ${response.statusMessage}');
      final response = Response(
          requestOptions: RequestOptions(path: 'path'),
          statusCode: 200,
          data: {
            "data": [
              {
                "id": "ce485015-a22d-4cb0-aa28-062977a99a32",
                "description": "test note description",
                "color": "#5ABB56",
                "owner_id": "4286a5e7-0396-44ad-bafe-50449510264d",
                "is_completed": true,
                "created_at": "2022-08-09T09:27:22.376056"
              },
              {
                "id": "17304797-d4ab-4852-ae27-2e44ccaa27dd",
                "description": "test note description1",
                "color": "#5ABB56",
                "owner_id": "4286a5e7-0396-44ad-bafe-50449510264d",
                "is_completed": true,
                "created_at": "2022-08-09T09:27:25.971956"
              },
              {
                "id": "bf33ceeb-22e1-4849-9055-d8965a256bb4",
                "description": "test note description2",
                "color": "#5ABB56",
                "owner_id": "4286a5e7-0396-44ad-bafe-50449510264d",
                "is_completed": false,
                "created_at": "2022-08-09T09:27:28.247146"
              }
            ]
          });
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![NotesScheme.data] as List<dynamic>)
          : throw Failure('Error: Get project error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateNote({required NotesModel noteModel}) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.put(
        path: '$_notes/${noteModel.id}',
        data: {
          NotesScheme.description: noteModel.description,
          NotesScheme.color: noteModel.color.toString().toStringColor(),
          NotesScheme.ownerId: ownerId,
          NotesScheme.isCompleted: noteModel.isCompleted,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('createNote ${response.data}');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  // @override
  // Future<Map<String, dynamic>> fetchOneNote({required String projectId}) async {
  //   try {
  //     final response = await _network.dio.get(
  //       '$_notes/$projectId',
  //       options: await _network.getLocalRequestOptions(),
  //     );
  //     log('deleteNote ${response.data}');
  //     return NetworkErrorService.isSuccessful(response)
  //         ? (response.data[NotesScheme.data] as Map<String, dynamic>)
  //         : throw Failure(
  //             'Error: ${response.data[NotesScheme.data][NotesScheme.message]}');
  //   } catch (e) {
  //     throw Failure(e.toString());
  //   }
  // }
}
