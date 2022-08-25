import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';

class NotesController {
  final NoteRepositoryImpl _notesRepository;
  NotesController({required NoteRepositoryImpl notesRepository})
      : _notesRepository = notesRepository;

  Future<void> createNote({
    required Color color,
    required String description,
  }) async {
    try {
      await _notesRepository.createNote(color: color, description: description);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteNote({required String projectId}) async {
    try {
      await _notesRepository.deleteNote(projectId: projectId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  // Future<NotesModel> fetchOneNote({required String projectId}) async {
  //   try {
  //     return _notesRepository.fetchOneNote(projectId: projectId);
  //   } catch (e) {
  //     throw Failure(e.toString());
  //   }
  // }

  Future<List<NotesModel>> fetchUserNotes() async {
    try {
      return _notesRepository.fetchUserNotes();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateNote({required NotesModel noteModel}) async {
    try {
      await _notesRepository.updateNote(noteModel: noteModel);
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
