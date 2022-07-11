import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

abstract class NoteRepository<T> {
  Future fetchNote();
  Future putNote({
       required String color,
    required String description,
    required BuildContext context,
  });
}

class NoteRepositoryImpl implements NoteRepository<NotesModel> {
  final _noteDataSource = NotesDataSourceImpl();
  @override
  Future<List<NotesModel>> fetchNote() async {
    try {
      final response = await _noteDataSource.fetchNote();
      if (response.hasError) {
        log(response.error!.message);
      }
      return (response.data as List<dynamic>)
          .map((json) => NotesModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
      rethrow;
    }
  }

  @override
  Future<void> putNote({
    required String color,
    required String description,
    required BuildContext context,
  }) async {
    try {
      final response = await _noteDataSource.putNote(
        color: color,
        description: description,
      );
      if (response.hasError) {

        MessageService.displaySnackbar(context: context, message: response.error!.message);
      }
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
      rethrow;
    }
  }
}
