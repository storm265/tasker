import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo2/database/scheme/checklists/checklist/checklist_dao.dart';
import 'package:todo2/database/scheme/checklists/checklist/checklist_table.dart';

part 'checklist_database.g.dart';

@DriftDatabase(tables: [CheckListTable], daos: [CheckListDaoImpl])
class CheckListDatabase extends _$CheckListDatabase {
  CheckListDatabase() : super(_database());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _database() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); //internal
    final dbFile = File(join(dbFolder.path, "checklist.db"));
    return NativeDatabase(dbFile);
  });
}
