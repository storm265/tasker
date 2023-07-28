import 'package:flutter/cupertino.dart';
import 'package:todo2/data/data_source/notes/notes_data_source.dart';
import 'package:todo2/domain/model/notes_model.dart';
import 'package:todo2/schemas/database_scheme/notes_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/network_error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/secure_storage_service/secure_storage_service.dart';
import 'package:todo2/services/secure_storage_service/storage_data_type.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class NotesDataSourceImpl implements NotesDataSource {
  NotesDataSourceImpl({
    required NetworkSource network,
    required SecureStorageSource secureStorage,
  })  : _network = network,
        _secureStorage = secureStorage;

  final NetworkSource _network;

  final SecureStorageSource _secureStorage;

  final _notes = '/notes';
  final _userNotes = '/user-notes';

  @override
  Future<Map<String, dynamic>> createNote({
    required Color color,
    required String description,
  }) async {
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
    return NetworkErrorService.isSuccessful(response)
        ? (response.data[NotesScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[NotesScheme.data][NotesScheme.message]}');
  }

  @override
  Future<void> deleteNote({required String projectId}) async {
    await _network.delete(
      path: '$_notes/$projectId',
      options: await _network.getLocalRequestOptions(),
    );
  }

  @override
  Future<List<dynamic>> fetchUserNotes() async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);
    final response = await _network.get(
      path: '$_userNotes/$ownerId',
      queryParameters: {
        NotesScheme.ownerId: ownerId,
      },
      options: await _network.getLocalRequestOptions(useContentType: true),
    );
    return NetworkErrorService.isSuccessful(response)
        ? (response.data![NotesScheme.data] as List<dynamic>)
        : throw Failure('Error: Get project error');
  }

  @override
  Future<Map<String, dynamic>> updateNote({
    required NotesModel noteModel,
    required String description,
    required Color color,
  }) async {
    final ownerId = await _secureStorage.getUserData(type: StorageDataType.id);
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
    return NetworkErrorService.isSuccessful(response)
        ? (response.data[NotesScheme.data] as Map<String, dynamic>)
        : throw Failure(
            'Error: ${response.data[NotesScheme.data][NotesScheme.message]}');
  }
}
