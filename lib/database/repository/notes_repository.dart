import 'package:flutter/cupertino.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class NoteRepository<T> {
  Future<void> createNote({
    required Color color,
    required String description,
  });

  Future<void> deleteNote({required String projectId});

  // Future<NotesModel> fetchOneNote({required String projectId});

  Future<List<NotesModel>> fetchUserNotes();

  Future<void> updateNote({required NotesModel noteModel});
}

class NoteRepositoryImpl implements NoteRepository<NotesModel> {
  final NotesDataSourceImpl _noteDataSource;

  NoteRepositoryImpl({required NotesDataSourceImpl noteDataSource})
      : _noteDataSource = noteDataSource;



  @override
  Future<void> createNote({
    required Color color,
    required String description,
  }) async {
    try {
      await _noteDataSource.createNote(
        color: color,
        description: description,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> deleteNote({required String projectId}) async {
    try {
      await _noteDataSource.deleteNote(projectId: projectId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  // @override
  // Future<NotesModel> fetchOneNote({
  //   required String projectId
  // })async {
  //   try {
  //     final response = await _noteDataSource.fetchUserNotes();
  //     List<NotesModel> notes = [];
  //     for (int i = 0; i < response.length; i++) {
  //       notes.add(NotesModel.fromJson(response[i]));
  //     }
  //     return notes;
  //   } catch (e) {
  //     throw Failure(e.toString());
  //   }
  // }

  @override
  Future<List<NotesModel>> fetchUserNotes() async {
    try {
      final response = await _noteDataSource.fetchUserNotes();
      List<NotesModel> notes = [];
      for (int i = 0; i < response.length; i++) {
        notes.add(NotesModel.fromJson(response[i]));
      }
      return notes;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateNote({required NotesModel noteModel}) async {
    try {
      await _noteDataSource.updateNote(noteModel: noteModel);
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
