import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:todo2/database/scheme/tables/checklist_item_table.dart';
import 'package:todo2/database/scheme/tables/checklist_table.dart';
import 'package:todo2/database/scheme/tables/note_table.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'app_db.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  NoteTable,
  CheckListTable,
  CheckListItemTable,
])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
