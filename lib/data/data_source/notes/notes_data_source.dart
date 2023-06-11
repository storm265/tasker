import 'package:flutter/cupertino.dart';
import 'package:todo2/domain/model/notes_model.dart';

abstract class NotesDataSource {
  Future<void> createNote({
    required Color color,
    required String description,
  });

  Future<void> deleteNote({required String projectId});

  Future<List<dynamic>> fetchUserNotes();

  Future<Map<String, dynamic>> updateNote({
    required NotesModel noteModel,
    required String description,
    required Color color,
  });
}
