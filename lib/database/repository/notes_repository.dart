import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class NoteRepository<T> {
  Future fetchNote();
  Future postNote({
    required String color,
    required String description,
  });
}

class NoteRepositoryImpl implements NoteRepository<NotesModel> {
  final _noteDataSource = NotesDataSourceImpl();
  @override
  Future<List<NotesModel>> fetchNote() async {
    try {
      final response = await _noteDataSource.fetchNote();
      return (response.data as List<dynamic>)
          .map((json) => NotesModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in NoteRepositoryImpl fetchNotes() :$e');
      rethrow;
    }
  }

  @override
  Future<void> postNote({
    required String color,
    required String description,
  }) async {
    try {
      await _noteDataSource.postNote(
        color: color,
        description: description,
      );
    } catch (e) {
      ErrorService.printError('Error in NoteRepositoryImpl fetchNotes():$e');
      rethrow;
    }
  }
}
