import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/notes/note_database.dart';
import 'package:todo2/database/scheme/notes/note_table.dart';
part 'note_dao.g.dart';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
@DriftAccessor(tables: [NoteTable])
class NoteDao extends DatabaseAccessor<NoteDatabase> with _$NoteDaoMixin {
  NoteDao(NoteDatabase noteDatabase) : super(noteDatabase);

  Future<List<Note>> getNotes() async {
    return await select(noteTable).get();       
  }
              
  Stream<List<Note>> getNotesStream() {
    return select(noteTable).watch();
  }

  Future<Note> getNote(String id) async {
    return await (select(noteTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateNote(NoteTableCompanion entity) async {
    return await update(noteTable).replace(entity);
  }

  Future<int> insertNote(NoteTableCompanion entity) async {
    return await into(noteTable).insert(entity);
  }

  Future<int> deleteNote(String id) async {
    return await (delete(noteTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
