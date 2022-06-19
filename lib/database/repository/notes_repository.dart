import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class NotesRepository<T> {
  Future<T> fetchNotes();
  Future<T> putNotes({
    required String color,
    required String description,
  });
}

class NotesRepositoryImpl implements NotesRepository {
  final _notesDataSource = NotesDataSourceImpl();
  @override
  Future<List<NotesModel>> fetchNotes() async {
    try {
      final _responce = await _notesDataSource.fetchNotes();

      return (_responce.data as List<dynamic>)
          .map((json) => NotesModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
    }
    throw Exception('Error in fetchNotes() repository');
  }

  @override
  Future<void> putNotes({
    required String color,
    required String description,
  }) async {
    try {
      await _notesDataSource.putNotes(
        color: color,
        description: description,
      );
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
    }
  
  }
}
