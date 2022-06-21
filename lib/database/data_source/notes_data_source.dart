import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/notes_scheme.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class NotesDataSource {
  Future fetchNote();
  Future putNote({
    required String color,
    required String description,
  });
}

class NotesDataSourceImpl implements NotesDataSource {
  final _table = 'notes';
  final _supabase = SupabaseSource().restApiClient;

  @override
  Future<PostgrestResponse<dynamic>> fetchNote() async {
    try {
      final response = await _supabase
          .from(_table)
          .select('${NotesScheme.description},${NotesScheme.color}')
          .eq(NotesScheme.ownerId, _supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> putNote({
    required String color,
    required String description,
  }) async {
    try {
      final response = await _supabase.from(_table).insert({
        NotesScheme.isCompleted: false,
        NotesScheme.color: color,
        NotesScheme.description: description,
        NotesScheme.createdAt: DateTime.now().toString(),
        NotesScheme.ownerId: _supabase.auth.currentUser!.id,
      }).execute();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
