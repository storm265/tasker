import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/notes_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class NotesDataSource<T> {
  Future<T> fetchNotes();
  Future<T> putNotes({
    required String color,
    required String description,
  });
}

class NotesDataSourceImpl implements NotesDataSource {
  final _table = 'notes';
  final _supabase = SupabaseSource().dbClient;
  @override
  Future<PostgrestResponse<dynamic>> fetchNotes() async {
    try {
      final _responce = await _supabase
          .from(_table)
          .select('${NotesScheme.description},${NotesScheme.color}')
          .eq(NotesScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() data source:$e');
    }
    return throw Exception('Error in fetchNotes() data source');
  }

  @override
  Future<PostgrestResponse<dynamic>> putNotes({
    required String color,
    required String description,
  }) async {
    try {
      final _responce = await _supabase.from(_table).insert({
        NotesScheme.isCompleted: false,
        NotesScheme.color: color,
        NotesScheme.description: description,
        NotesScheme.createdAt: DateTime.now().toString(),
        NotesScheme.ownerId: _supabase.auth.currentUser!.id,
      }).execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in putNotes() data source:$e');
    }
    return throw Exception('Error in putNotes() data source');
  }
}
