import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo2/data/data_source/notes/notes_data_source_impl.dart';
import 'package:todo2/domain/model/notes_model.dart';
import 'package:todo2/domain/repository/notes_repository.dart';
import 'package:todo2/schemas/notes/note_dao.dart';
import 'package:todo2/schemas/notes/note_database.dart';
import 'package:todo2/services/cache_service/cache_keys.dart';
import 'package:todo2/services/cache_service/cache_service.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({
    required NotesDataSourceImpl noteDataSource,
    required NoteDao noteDao,
    required InMemoryCache inMemoryCache,
  })  : _noteDataSource = noteDataSource,
        _noteDao = noteDao,
        _inMemoryCache = inMemoryCache;

  final InMemoryCache _inMemoryCache;

  final NoteDao _noteDao;

  final NotesDataSourceImpl _noteDataSource;

  @override
  Future<NotesModel> createNote({
    required Color color,
    required String description,
  }) async {
    final response = await _noteDataSource.createNote(
      color: color,
      description: description,
    );
    return NotesModel.fromJson(response);
  }

  @override
  Future<void> deleteNote({required String projectId}) =>
      _noteDataSource.deleteNote(projectId: projectId);

  @override
  Future<List<NotesModel>> fetchUserNotes() async {
    List<NotesModel> notes = [];
    if (_inMemoryCache.shouldFetchOnlineData(
        date: DateTime.now(), key: CacheKeys.quick)) {
      final response = await _noteDataSource.fetchUserNotes();

      await _noteDao.deleteAllNotes();
      for (int i = 0; i < response.length; i++) {
        notes.add(NotesModel.fromJson(response[i]));
        await _noteDao.insertNote(
          NoteTableCompanion(
            id: Value(notes[i].id),
            description: Value(notes[i].description),
            ownerId: Value(notes[i].ownerId),
            color: Value(notes[i].color.toString().toStringColor()),
            isCompleted: Value(notes[i].isCompleted),
            createdAt: Value(notes[i].createdAt.toIso8601String()),
          ),
        );
      }

      return notes;
    } else {
      final list = await _noteDao.getNotes();
      for (int i = 0; i < list.length; i++) {
        notes.add(NotesModel.fromJson(list[i].toJson()));
      }

      return notes;
    }
  }

  @override
  Future<NotesModel> updateNote({
    required NotesModel noteModel,
    required String description,
    required Color color,
  }) async {
    final response = await _noteDataSource.updateNote(
      noteModel: noteModel,
      description: description,
      color: color,
    );
    return NotesModel.fromJson(response);
  }
}
