import 'package:flutter/cupertino.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/notes_model.dart';

abstract class NoteRepository {
  Future<NotesModel> createNote({
    required Color color,
    required String description,
  });

  Future<void> deleteNote({required String projectId});

  Future<List<NotesModel>> fetchUserNotes();

  Future<NotesModel> updateNote({
    required NotesModel noteModel,
    required String description,
    required Color color,
  });
}

class NoteRepositoryImpl implements NoteRepository {
  final NotesDataSourceImpl _noteDataSource;

  NoteRepositoryImpl({required NotesDataSourceImpl noteDataSource})
      : _noteDataSource = noteDataSource;

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
  Future<void> deleteNote({required String projectId}) async =>
      await _noteDataSource.deleteNote(projectId: projectId);

  @override
  Future<List<NotesModel>> fetchUserNotes() async {
    final response = await _noteDataSource.fetchUserNotes();
    List<NotesModel> notes = [];
    for (int i = 0; i < response.length; i++) {
      notes.add(NotesModel.fromJson(response[i]));
    }
    return notes;
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
