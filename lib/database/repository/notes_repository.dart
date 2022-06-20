import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class NoteRepository<T> {
  Future<T> fetchNote();
  Future<T> putNote({
    required String color,
    required String description,
  });
}

class NoteRepositoryImpl implements NoteRepository {
  final _noteDataSource = NotesDataSourceImpl();
  @override
  Future<List<NotesModel>> fetchNote() async {
    try {
      final _responce = await _noteDataSource.fetchNote();

      return (_responce.data as List<dynamic>)
          .map((json) => NotesModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
    }
    throw Exception('Error in fetchNotes() repository');
  }

  @override
  Future<void> putNote({
    required String color,
    required String description,
  }) async {
    try {
      await _noteDataSource.putNote(
        color: color,
        description: description,
      );
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
    }
  }
}
