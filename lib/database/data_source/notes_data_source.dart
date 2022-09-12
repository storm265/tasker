import 'dart:developer';
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
  Future<void> updateNote({
    required NotesModel noteModel,
    required String description,
    required Color color,
  });
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
      await _network.post(
        path: _notes,
        data: {
          NotesScheme.description: description,
          NotesScheme.color: color.toString().toStringColor(),
          NotesScheme.ownerId: id,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
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
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<dynamic>> fetchUserNotes() async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.get(
        path: '$_notes/$ownerId',
        queryParameters: {
          NotesScheme.ownerId: ownerId,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      return NetworkErrorService.isSuccessful(response)
          ? (response.data![NotesScheme.data] as List<dynamic>)
          : throw Failure('Error: Get project error');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateNote({
    required NotesModel noteModel,
    required String description,
    required Color color,
  }) async {
    try {
      final ownerId =
          await _secureStorage.getUserData(type: StorageDataType.id);
      final response = await _network.put(
        path: '$_notes/${noteModel.id}',
        data: {
          NotesScheme.description: description,
          NotesScheme.color: color.toString().toStringColor(),
          NotesScheme.ownerId: ownerId,
          NotesScheme.isCompleted: noteModel.isCompleted,
        },
        options: await _network.getLocalRequestOptions(useContentType: true),
      );
      log('updateNote ${response.statusMessage}');
      log('updateNote ${response.statusCode}');
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
  //     return NetworkErrorService.isSuccessful(response)
  //         ? (response.data[NotesScheme.data] as Map<String, dynamic>)
  //         : throw Failure(
  //             'Error: ${response.data[NotesScheme.data][NotesScheme.message]}');
  //   } catch (e) {
  //     throw Failure(e.toString());
  //   }
  // }
}
