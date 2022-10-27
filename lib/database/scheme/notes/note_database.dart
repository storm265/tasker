import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo2/database/scheme/notes/note_dao.dart';
import 'package:todo2/database/scheme/notes/note_table.dart';

part 'note_database.g.dart';

@DriftDatabase(tables: [NoteTable], daos: [NoteDao])
class NoteDatabase extends _$NoteDatabase {
  NoteDatabase() : super(_database());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _database() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); //internal
    final dbFile = File(join(dbFolder.path, "note.db"));
    return NativeDatabase(dbFile);
  });
}
