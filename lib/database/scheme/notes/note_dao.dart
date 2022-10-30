import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/notes/note_database.dart';
import 'package:todo2/database/scheme/notes/note_table.dart';
part 'note_dao.g.dart';

abstract class NoteDao {
  Future<List<Note>> getNotes();

  Stream<List<Note>> getNotesStream();

  Future<Note> getNote(String id);

  Future<bool> updateNote(NoteTableCompanion entity);

  Future<int> insertNote(NoteTableCompanion entity);

  Future<int> deleteNote(String id);
}

@DriftAccessor(tables: [NoteTable])
class NoteDaoImpl extends DatabaseAccessor<NoteDatabase>
    with _$NoteDaoMixin
    implements NoteDao {
  NoteDaoImpl(NoteDatabase noteDatabase) : super(noteDatabase);

  @override
  Future<List<Note>> getNotes() async {
    return await select(noteTable).get();
  }

  @override
  Stream<List<Note>> getNotesStream() {
    return select(noteTable).watch();
  }

  @override
  Future<Note> getNote(String id) async {
    return await (select(noteTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  @override
  Future<bool> updateNote(NoteTableCompanion entity) async {
    return await update(noteTable).replace(entity);
  }

  @override
  Future<int> insertNote(NoteTableCompanion entity) async {
    return await into(noteTable).insert(entity);
  }

  @override
  Future<int> deleteNote(String id) async {
    return await (delete(noteTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
