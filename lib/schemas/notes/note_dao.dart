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
  Future<List<Note>> getNotes() => select(noteTable).get();

  @override
  Stream<List<Note>> getNotesStream() => select(noteTable).watch();

  @override
  Future<Note> getNote(String id) =>
      (select(noteTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  @override
  Future<bool> updateNote(NoteTableCompanion entity) =>
      update(noteTable).replace(entity);

  @override
  Future<int> insertNote(NoteTableCompanion entity) =>
      into(noteTable).insert(entity);

  @override
  Future<int> deleteNote(String id) =>
      (delete(noteTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  Future<int> deleteAllNotes() => (delete(noteTable)).go();
}
