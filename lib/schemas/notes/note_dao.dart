import 'package:drift/drift.dart';
import 'note_database.dart';
import 'note_table.dart';
part 'note_dao.g.dart';

abstract class NoteDao {
  Future<List<Note>> getNotes();

  Stream<List<Note>> getNotesStream();

  Future<Note> getNote(String id);

  Future<bool> updateNote(NoteTableCompanion entity);

  Future<int> insertNote(NoteTableCompanion entity);

  Future<int> deleteNote(String id);

  Future<int> deleteAllNotes();
}

@DriftAccessor(tables: [NoteTable])
class NoteDaoImpl extends DatabaseAccessor<NoteDatabase>
    with _$NoteDaoImplMixin
    implements NoteDao {
  NoteDaoImpl(NoteDatabase noteDatabase) : super(noteDatabase);

  @override
  Future<List<Note>> getNotes() async => await select(noteTable).get();

  @override
  Stream<List<Note>> getNotesStream() => select(noteTable).watch();

  @override
  Future<Note> getNote(String id) async =>
      await (select(noteTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  @override
  Future<bool> updateNote(NoteTableCompanion entity) async =>
      await update(noteTable).replace(entity);

  @override
  Future<int> insertNote(NoteTableCompanion entity) async =>
      await into(noteTable).insert(entity);

  @override
  Future<int> deleteNote(String id) async =>
      await (delete(noteTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  Future<int> deleteAllNotes() async {
    return await (delete(noteTable)).go();
  }
}
