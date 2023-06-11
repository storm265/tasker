import 'package:flutter/material.dart';
import 'package:todo2/domain/model/notes_model.dart';

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
