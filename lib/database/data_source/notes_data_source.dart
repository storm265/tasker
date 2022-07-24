import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/notes_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network/constants.dart';

abstract class NotesDataSource {
  Future fetchNote();
  Future postNote({
    required String color,
    required String description,
  });
}

class NotesDataSourceImpl implements NotesDataSource {
  final _table = 'notes';
  final _supabase = NetworkSource().networkApiClient;

  @override
  Future<PostgrestResponse<dynamic>> fetchNote() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select('${NotesScheme.description},${NotesScheme.color}')
      //     .eq(NotesScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError('Error in NotesDataSourceImpl fetchNotes() :$e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> postNote({
    required String color,
    required String description,
  }) async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   NotesScheme.isCompleted: false,
      //   NotesScheme.color: color,
      //   NotesScheme.description: description,
      //   NotesScheme.ownerId: _supabase.auth.currentUser!.id,
      //   NotesScheme.createdAt: DateTime.now().toString(),
      // }).execute();
      // return response;
               return     Future.delayed( Duration(seconds: 1));
    } catch (e) {
      ErrorService.printError('Error in NotesDataSourceImpl putNote() :$e');
      rethrow;
    }
  }
}
